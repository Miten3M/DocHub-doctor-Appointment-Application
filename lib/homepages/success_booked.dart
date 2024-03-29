import 'package:doc_hub/homepages/Main_Layout.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/pageimages/success.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            //back to home page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                ),
                //width: double.infinity,
                child: Text( 'Back to Home Page'),
                onPressed: () => Get.offAll(() => MainLayout()),
              ),
              // child: Button(
              //   width: double.infinity,
              //   title: 'Back to Home Page',
              //   onPressed: () => Navigator.of(context).pushNamed('main'),
              //   disable: false,
              // ),
            )
          ],
        ),
      ),
    );
  }
}