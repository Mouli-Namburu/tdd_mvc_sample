import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tdd_mvc_sample/controllers/user_controller.dart';

void main() {
  group('UserController Tests', () {
    late UserController userController;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient((http.Request request) async {
        if (request.url.toString() == 'https://json-placeholder.mock.beeceptor.com/users') {
          return http.Response(jsonEncode([
            {
              'id': 1,
              'name': 'Test User',
              'company': 'Test Company',
              'username': 'testuser',
              'email': 'test@example.com',
              'address': '123 Test Street',
              'zip': '12345',
              'state': 'TestState',
              'country': 'TestCountry',
              'phone': '123-456-7890'
            }
          ]), 200);
        }
        return http.Response('Not Found', 404);
      });
      userController = UserController(client: mockClient);
    });

    test('Initial users should be empty', () {
      expect(userController.users, isEmpty);
    });

    test('Successful fetch populates users', () async {
      await userController.fetchUsers();
      expect(userController.users, isNotEmpty);
      expect(userController.users.first.name, equals('Test User'));
    });

    test('Fetch with server error throws exception', () async {
      mockClient = MockClient((request) async => http.Response('Server Error', 500));
      userController = UserController(client: mockClient);

      expect(() async => await userController.fetchUsers(), throwsA(isA<Exception>()));
    });

    test('Fetch with invalid data throws exception', () async {
      mockClient = MockClient((request) async => http.Response('Invalid Data', 200));
      userController = UserController(client: mockClient);

      expect(() async => await userController.fetchUsers(), throwsA(isA<Exception>()));
    });
  });
}
