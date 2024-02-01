import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../models/auth/login_model.dart';

class LoginController extends ChangeNotifier {
  bool _isLoggedIn = false;
  late final http.Client httpClient;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  LoginController({http.Client? httpClient}) : this.httpClient = httpClient ?? http.Client();

  final apiUrl = 'https://json-placeholder.mock.beeceptor.com/login';

  Future<void> loginUser(String username, String password) async {
    final response = await httpClient.post(Uri.parse(apiUrl), body: {
      'username': username,
      'password': password,
    });

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final loginResponse = LoginModel.fromJson(jsonResponse);

    if (response.statusCode == 200 && loginResponse.success) {
      isLoggedIn = true;
      notifyListeners();
    } else {
      isLoggedIn = false;
      notifyListeners();
    }
  }
}



