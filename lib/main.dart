import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/homepages/Main_Layout.dart';
import 'package:doc_hub/homepages/booking_page.dart';
import 'package:doc_hub/homepages/doctor_details.dart';

import 'package:doc_hub/login/phone.dart';
import 'package:doc_hub/widges/themes.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: MyTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      // darkTheme: MyTheme.darkTheme(context),
      home: const MyPhone(),
      // initialRoute: '/',
      // debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/main', page: () => MainLayout()),
        GetPage(name: '/doc_details', page: () => const DoctorDetails()),
        GetPage(
            name: '/booking_page',
            page: () =>BookingPage(),
            transition: Transition.zoom
        ),
      ],
    );
  }
}
