import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tdd_mvc_sample/controllers/auth/login_controller.dart';
import 'package:tdd_mvc_sample/views/auth/login_page.dart';
import 'package:tdd_mvc_sample/views/home_page.dart';


class MockLoginController extends Mock implements LoginController {
  @override
  bool get isLoggedIn => super.noSuchMethod(
    Invocation.getter(#isLoggedIn),
    returnValue: false, // Provide a default return value
    returnValueForMissingStub: false,
  ) as bool;
}

void main() {


  group('LoginPage Widget Tests', () {

    late MockLoginController mockLoginController;

    setUp(() {
      mockLoginController = MockLoginController();
    });

    testWidgets('Renders LoginPage correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      expect(find.text('Login Page'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });


    testWidgets('check on tap Login ',
            (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(home: LoginPage()));

          final loginButton = find.text('Login');

          await tester.tap(loginButton);
          await tester.pumpAndSettle();

          expect(loginButton, findsOneWidget);
        });


   /* testWidgets('Successful login navigates to HomePage', (WidgetTester tester) async {
      when(mockLoginController.isLoggedIn).thenReturn(true);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<LoginController>(
            create: (_) => mockLoginController,
            child: LoginPage(),
          ),
        ),
      );

      // Enter valid username and password
      await tester.enterText(find.byKey(const Key("Username")), "validUsername");
      await tester.enterText(find.byKey(const Key("Password")), "validPassword");

      // Tap on the login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify if HomePage is pushed
      expect(find.byType(HomePage), findsOneWidget);
    });*/
  });


}


