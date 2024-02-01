import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserController extends ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  http.Client httpClient;

  UserController({http.Client? client}) : httpClient = client ?? http.Client();

  Future<void> fetchUsers() async {
    try {
      final response = await httpClient.get(Uri.parse('https://json-placeholder.mock.beeceptor.com/users'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        _users = jsonData.map((data) => UserModel.fromJson(data)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (error) {
      throw Exception('Failed to fetch users: $error');
    }
  }

}
