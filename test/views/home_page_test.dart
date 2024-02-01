import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tdd_mvc_sample/views/home_page.dart';


void main() {
  group('HomePage Tests', () {

    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient((http.Request request) async {
        if (request.url.toString() ==
            'https://json-placeholder.mock.beeceptor.com/users') {
          return http.Response(
              jsonEncode([
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
                  'phone': '123-456-7890',
                }
              ]),
              200);
        }
        return http.Response('Not Found', 404);
      });
    });

    testWidgets('HomePage widget renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(client: mockClient,),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('User List'), findsOneWidget);
      expect(find.text('Test User'), findsOneWidget);
    });


    testWidgets('CircularProgressIndicator is displayed when user list is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(client: mockClient,),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

  });
}
