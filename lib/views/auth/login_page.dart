// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


import '../../controllers/auth/login_controller.dart';
import '../home_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = Provider.of<LoginController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (context, loginController, _) {
        return Column(
          children: [
            TextField(
              key: const Key("Username"),
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              key: const Key("Password"),
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async =>
              {
                if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty)
                  {
                    await _loginController.loginUser(_usernameController.text, _passwordController.text),

                    if (_loginController.isLoggedIn)
                      {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(client: http.Client(),),
                          ),
                        )
                      }
                  }
                else
                  {
                    Fluttertoast.showToast(
                      msg: 'Fields should not be empty',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    )
                  }
              },
              child: const Text('Login'),
            ),
          ],
        );
      },
    );
  }
}
