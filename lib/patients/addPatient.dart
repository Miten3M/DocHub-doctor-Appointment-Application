import 'package:doc_hub/Repository/PatientRepository.dart';
import 'package:doc_hub/components/custom_appbar.dart';
import 'package:doc_hub/components/my_button.dart';
import 'package:doc_hub/components/my_textfield.dart';
import 'package:doc_hub/contants/text_strings.dart';
import 'package:doc_hub/controllers/patient_Controller.dart';
import 'package:doc_hub/controllers/profile_controller.dart';
import 'package:doc_hub/models/patient.dart';
import 'package:doc_hub/models/user.dart';
import 'package:doc_hub/patients/patients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';

enum Gender { Male, Female }

class AddPatient extends StatefulWidget {
  const AddPatient({Key? key}) : super(key: key);

  @override
  State<AddPatient> createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  Gender? _gender = Gender.Male;

  final patientRepo = Get.put(PatientRepository());
  DateTime birthdate = DateTime(2002, 09, 07);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatientController());
    final controller1 = Get.put(ProfileController());


    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Doctor Details',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () => Get.to(Patient()),
      //       icon: const Icon(LineAwesomeIcons.angle_left)),
      //   centerTitle: true,
      //   title: Text(
      //     "Patient Details",
      //     style: TextStyle(color: Colors.black),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: controller1.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data as UserModel;
                return Column(
                  children: [
                    SizedBox(height: 10),
                    Form(
                        child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        MyTextField(
                          controller: controller.PName,
                          hintText: taddPatient,
                          obscureText: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Date Of Birth', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            30,
                            0,
                            30,
                            0,
                          ),
                          child: DropdownDatePicker(
                            inputDecoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            // optional
                            isDropdownHideUnderline: true,
                            // optional
                            isFormValidator: true,
                            // optional
                            startYear: 1900,
                            // optional
                            endYear: 2023,
                            // optional
                            width: 10,
                            // optional
                            // selectedDay: 14, // optional
                            //selectedMonth: 10, // optional
                            //selectedYear: 1993, // optional
                            onChangedDay: (day) => birthdate.day,
                            onChangedMonth: (month) => birthdate.month,
                            onChangedYear: (year) => birthdate.year,

                            boxDecoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0)),
                            // optional
                            // showDay: false,// optional
                            // dayFlex: 2,// optional
                            // locale: "zh_CN",// optional
                            hintDay: 'Day',
                            // optional
                            hintMonth: 'Month',
                            // optional
                            hintYear: 'Year',
                            // optional
                            hintTextStyle:
                                TextStyle(color: Colors.grey, fontSize: 15),
                            // optional
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Gender',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: Gender.Male,
                              groupValue: _gender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            Text(
                              'Male',
                              style: TextStyle(fontSize: 18),
                            ),
                            Radio(
                              value: Gender.Female,
                              groupValue: _gender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            Text('Female', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: controller.PNumber,
                          hintText: tPatientNumber,
                          obscureText: false,
                        ),
                        const SizedBox(height: 20),
                        MyTextField(
                          controller: controller.PEmail,
                          hintText: tPEmail,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MyButton(
                          text: "Add Patient",
                          onTap: () {
                            final patient = PatientModel(
                                patientName: controller.PName.text.trim(),
                                age: calculateAge(birthdate).toString(),
                                gender: _gender.toString(),
                                pNumber: controller.PNumber.text.trim());

                            patientRepo.addPatient(patient, userData.id);
                            Get.to(() => Patient());
                          },
                        ),
                      ],
                    ))
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: Text("Something went wrong"));
              }
            }),
      ),
    );
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
