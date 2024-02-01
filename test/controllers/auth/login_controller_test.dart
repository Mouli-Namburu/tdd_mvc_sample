import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_mvc_sample/controllers/auth/login_controller.dart';


void main() {
  late LoginController loginController;

  setUp(() => loginController = LoginController());

  test('LoginController initializes with isLoggedIn=false', () {
    final loginController = LoginController();
    expect(loginController.isLoggedIn, false);
  });

  test('Login with correct credentials should succeed', () async {
    await loginController.loginUser("michael", 'success-password');
    expect(loginController.isLoggedIn, true);
  });


  test('Login with incorrect credentials should fail', () async {
    await loginController.loginUser("user123", 'failed-password');
    expect(loginController.isLoggedIn, false);
  });
}
