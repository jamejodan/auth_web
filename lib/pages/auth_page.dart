import 'package:firebase_auth_test/pages/login_page.dart';
import 'package:firebase_auth_test/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showRegisterPage: toggle,
      );
    } else {
      return RegisterPage(
        showLoginPage: toggle,
      );
    }
  }
}
