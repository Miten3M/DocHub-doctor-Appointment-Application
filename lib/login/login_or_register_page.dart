import 'package:doc_hub/login/doctor_page.dart';
import 'package:doc_hub/login/phone.dart';
import 'package:flutter/material.dart';



class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // initially show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return MyPhone(
        onTap: togglePages,
      );
    } else {
      return DocterPage(
        onTap: togglePages,
      );
    }
  }
}
