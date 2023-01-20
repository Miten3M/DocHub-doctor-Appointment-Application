import 'package:doc_hub/login/aboutUs.dart';
import 'package:doc_hub/login/auth_page.dart';
import 'package:doc_hub/login/homepage.dart';
import 'package:doc_hub/login/phone.dart';
import 'package:doc_hub/login//verify.dart';
import 'package:doc_hub/login/profile_screen.dart';
import 'package:doc_hub/widges/themes.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: MyTheme.lightTheme(context),
      // debugShowCheckedModeBanner: false,
      darkTheme: MyTheme.darkTheme(context),
      // home: MyPhone(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        'phone': (context) => MyPhone(),
        'verify': (context) => MyVerify(),
        'home':(context)=>HomePage(),
        '/':(context)=>AuthPage()
      },
    );
  }
}
