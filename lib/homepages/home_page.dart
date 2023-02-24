
import 'package:doc_hub/homepages/appointment_card.dart';
import 'package:doc_hub/homepages/config.dart';
import 'package:doc_hub/homepages/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String,dynamic>> medCat=[
    {
      "icon":FontAwesomeIcons.userDoctor,
      "category":"General",
    },
    {
      "icon":FontAwesomeIcons.heartPulse,
      "category":"Cardiology",
    },
    {
      "icon":FontAwesomeIcons.lungs,
      "category":"Respirations",
    },
    {
      "icon":FontAwesomeIcons.hand,
      "category":"Dermatology",
    },
    {
      "icon":FontAwesomeIcons.personPregnant,
      "category":"Gynecology",
    },
    {
      "icon":FontAwesomeIcons.teeth,
      "category":"Dental",
    },
  ];
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Darshil',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/pageimages/User-Avatar.png"),
                    ),
                  )
                ],
              ),
              Config.spaceMedium,
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              SizedBox(
                height: Config.heightSize * 0.05,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(medCat.length, (index){
                    return Card(
                      margin: const EdgeInsets.only(right:20),
                      color: Config.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FaIcon(medCat[index]['icon'],color:Colors.white,),
                            const SizedBox(width: 20,),
                            Text(
                              medCat[index]['category'],
                              style: const TextStyle(
                                fontSize: 16,
                                color:Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Config.spaceSmall,
              const Text(
                'Appointment Today',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              Appointmentcard(),
              Config.spaceSmall,
              const Text(
                'Top Doctors',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              Column(
                children: List.generate(10, (index){
                  return const DoctorCard(
                    route: 'doc_details',
                  );
                }),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}