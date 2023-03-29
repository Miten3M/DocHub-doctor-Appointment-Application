import 'package:doc_hub/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'About us',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children:  <Widget>[
              Image.asset('assets/pageimages/info.png',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15),
              Text("App info",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      textBaseline: TextBaseline.alphabetic)),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "This app is a solution for booking an appointment with a doctor remotely. This is a secure and modern way of solving this issue. With the help of this app, you can easily see the available doctor on specific dates and time. You can also book an appointment with the doctor. This app is developed by a team of two students of the Information Technology Department, DDIT. The app is developed by the following members:\n\nMithaiwala Miten Manishkumar (IT078)\nKothari Darshil Rakeshbhai(IT066)",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                        fontFamily: 'Roboto'

                    ),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
