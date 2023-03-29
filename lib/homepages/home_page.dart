
import 'package:doc_hub/controllers/doctor_list_controller.dart';
import 'package:doc_hub/controllers/profile_controller.dart';
import 'package:doc_hub/homepages/appointment_card.dart';
import 'package:doc_hub/homepages/config.dart';
import 'package:doc_hub/homepages/doctor_card.dart';
import 'package:doc_hub/models/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
    final controller = Get.put(DoctorListController());
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child:SingleChildScrollView(
            child: FutureBuilder(
              future: controller.getAllDoctor(),
              builder: (context, snapshot) {
                print("Connetction not done");
                if (snapshot.connectionState == ConnectionState.done) {
                  print("Connetction done");
                  if (snapshot.hasData) {


                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Miten",
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
                          children: List.generate(snapshot.data!.length, (index){
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              height: 150,
                              child: GestureDetector(
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Config.widthSize * 0.33,
                                        child: Image.asset('assets/pageimages/homePage/1.jpg',fit: BoxFit.fill,),
                                      ),
                                      Flexible(child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data![index].doctorName,
                                              style:TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                             Text(
                                               snapshot.data![index].doctorSpecialty,
                                              style:TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children:  <Widget>[
                                                Icon(Icons.star_border, color: Colors.yellow,size: 16,),
                                                Spacer(flex: 1,),
                                                Text(snapshot.data![index].doctorRating,),
                                                Spacer(flex: 1,),
                                                Text('Reviews'),
                                                Spacer(flex: 1,),
                                                Text('(${snapshot.data![index].doctorNumberOfPatient})'),
                                                Spacer(flex: 7,),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: (){
                                  // Navigator.of(context).pushNamed(route);
                                  Get.toNamed('/doc_details',arguments: snapshot.data![index].doctorName);
                                },
                              ),
                            );
                          }),
                        ),
                      ],
                    );

                } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
                } else {
                return const Center(child: Text("Something went wrong"));
                }
                } else {
                return const Center(child: CircularProgressIndicator());
                }
              },
            ),

          ),
        ),
      ),
    );
  }
}