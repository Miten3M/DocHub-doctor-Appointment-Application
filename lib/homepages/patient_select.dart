import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/components/custom_appbar.dart';
import 'package:doc_hub/controllers/patient_Controller.dart';
import 'package:doc_hub/homepages/Main_Layout.dart';
import 'package:doc_hub/homepages/booking_page.dart';
import 'package:doc_hub/homepages/config.dart';
import 'package:doc_hub/models/patient.dart';
import 'package:doc_hub/patients/addPatient.dart';
import 'package:doc_hub/profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Patient_select extends StatefulWidget {
  const Patient_select ({Key? key}) : super(key: key);

  @override
  State<Patient_select > createState() => _Patient_selectState();
}

class _Patient_selectState extends State<Patient_select > {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatientController());

    return Scaffold(
       appBar: CustomAppBar(
         appTitle: 'Patient',
        icon: const FaIcon(Icons.arrow_back_ios),
       ),

      body: Container(
        // padding: const EdgeInsets.all(30),
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: FutureBuilder<List<PatientModel>>(
          future: controller.getAllPatient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.length>0) {
                // print("Snapshot has data");
                print(Get.arguments['doc_id']);

                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (p, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                child: ListTile(
                                  onTap:(){
                                  Get.to(BookingPage(),arguments: {"p_id":snapshot.data![index].id,"doc_id":'${Get.arguments['doc_id']}'});},

                                  iconColor: Config.primaryColor,
                                  tileColor: Colors.teal.withOpacity(0.3),
                                  leading: const Icon(LineAwesomeIcons.user_1),
                                  title: Text(
                                      "Name : ${snapshot.data![index].patientName}"),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Gender : ${snapshot.data![index].gender}    Age : ${snapshot.data![index].age} "),
                                      Text(snapshot.data![index].pNumber),
                                      (snapshot.data![index].email != null)
                                          ? Text(snapshot.data![index].email!)
                                          : const Text(""),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Config.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Get.to(() =>  AddPatient());
                          },
                          child: Text("Add Patient")),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        'assets/pageimages/addPatient.png',
                        fit: BoxFit.cover
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Add Patient",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "We need add details of patients before getting appointment!",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Config.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Get.to(() => const AddPatient());
                          },
                          child: Text("Add Patient")),
                    ),
                  ],
                );
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
