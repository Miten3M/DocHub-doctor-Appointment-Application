import 'package:doc_hub/controllers/doctor_info_controller.dart';
import 'package:doc_hub/homepages/booking_page.dart';
import 'package:doc_hub/homepages/patient_select.dart';
import 'package:doc_hub/models/doctor.dart';
import 'package:get/get.dart';
import 'package:doc_hub/homepages/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/custom_appbar.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  var data = Get.arguments;
  bool isFav=false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorInfoController());
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Doctor Details',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body:
     SafeArea(
        child: FutureBuilder(
          future: controller.getDoctorDetails(data),
          builder: (context, snapshot) {
            print("Connetction not done");
            if (snapshot.connectionState == ConnectionState.done) {
              print("Connetction done");
              if (snapshot.hasData) {
                DoctorModel docData = snapshot.data as DoctorModel;

                return  Column(

                  children: <Widget>[
                    AboutDoctor(name:docData.doctorName, hospital: docData.doctorHospital, degree:docData.doctorDegree),
                    DetailBody(info: docData.doctorDescription, tPatient:docData.doctorNumberOfPatient, experiance:docData.doctorYearOfExperience, rate: docData.doctorRating),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: Text(
                            'Book Appointment',style: TextStyle(fontSize: 13),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                        ),
                        onPressed: (){
                          print(docData.id);
                          Get.to(Patient_select(),arguments:{ "doc_id":docData.id});
                        },
                      ),
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

      );

  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({Key? key, required this.name, required this.hospital, required this.degree}) : super(key: key);
  final String name;
  final String degree;
  final String hospital;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Config.spaceSmall,
          const CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('assets/pageimages/homePage/1.jpg'),
            backgroundColor: Colors.white,
          ),
          Config.spaceSmall,
           Text(
           name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize*0.75,
            child:  Text(
              degree,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize*0.75,
            child:  Text(
              hospital,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({Key? key, required this.info, required this.tPatient, required this.experiance, required this.rate}) : super(key: key);
  final String info;
  final String tPatient;
  final String experiance;
  final String rate;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          DoctorInfo(tPatient: tPatient, experiance: experiance, rate: rate),
          Config.spaceMedium,
          const Text(
            'About Doctor',
            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
          ),
          Config.spaceSmall,
           Text(
            info,
             style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({Key? key, required this.tPatient, required this.experiance, required this.rate}) : super(key: key);
  final String tPatient;
  final String experiance;
  final String rate;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InfoCard(label: 'Patient',value:tPatient),
        SizedBox(width: 15,),
        InfoCard(label: 'Experiences',value:experiance),
        SizedBox(width: 15,),
        InfoCard(label: 'Rating',value: rate),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.label,required this.value}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Config.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10,),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
