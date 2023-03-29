import 'package:doc_hub/homepages/success_booked.dart';
import 'package:doc_hub/models/appointmentcard.dart';
import 'package:doc_hub/models/appointments.dart';
import 'package:doc_hub/models/doctor.dart';

import 'package:doc_hub/models/doctor.dart';
import 'package:doc_hub/models/patient.dart';
import 'package:doc_hub/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentRepository extends GetxController {
  static AppointmentRepository get instance => Get.find();

  final _db=FirebaseFirestore.instance;

  addAppointment(AppointmentModel appointmentModel,String? pid,String? email) async
  {

    final snapshot1=await _db.collection("Users").where("Email",isEqualTo: email).get();
    final userData=snapshot1.docs.map((e) => UserModel.fromSnapshot(e)).single;
    print(userData.id);
    await _db.collection("Users").doc(userData.id).collection("Patient").doc(pid!).collection("Appointment").add(appointmentModel.toJson()).whenComplete(

        ()async =>   await _db.collection("Appointments").add(appointmentModel.toJson()).whenComplete(() => Get.to(AppointmentBooked()))


    )
        .catchError((error,stackTrace){
      Get.snackbar("Error", "Something went wrong.Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  Future<List<AppointmentCardModel>> getAppointment(String? email)async{
    print("appointmentRepo");
    final snapshot1 = await _db.collection("User")
        .where("email", isEqualTo:email )
        .get();
    final userData=snapshot1.docs.map((e) => UserModel.fromSnapshot(e)).single;
    print(userData.email);
    final snapshot=await _db.collection("Users").doc(userData.id).collection("Patient").get();
    final patientData=snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    var appointData=<AppointmentModel>[];
    for (int i = 0; i < patientData.length; i++) {
      // Do something with myIntList[i]
      final snapshot3=await _db.collection("Users").doc(userData.id).collection("Patient").doc(patientData[i].id).collection("Appointment").get();
      final appointData1=snapshot3.docs.map((e) => AppointmentModel.fromSnapshot(e)).toList();
      appointData.addAll(appointData1);
    }

    //return appointData;
    final snapshot3=await _db.collection("Doctor").get();

    final docData=snapshot.docs.map((e) => DoctorModel.fromSnapshot(e)).toList();
    // return docData;
    List<AppointmentCardModel>? combinedList = appointData.map((AppointmentModel) {
      var matchingModel2 = docData.where((DoctorModel) => DoctorModel.id == AppointmentModel.doc_id).toList();
      if (matchingModel2.isNotEmpty) {
        return AppointmentCardModel(doctor_name: matchingModel2[0].doctorName , p_id: AppointmentModel.p_id, doc_id:matchingModel2[0].id, date: AppointmentModel.date, time: AppointmentModel.time, day: AppointmentModel.day, status: AppointmentModel.status, doc_profile: matchingModel2[0].doctorPicture, category:matchingModel2[0].doctorSpecialty);
      } else {
        return null;
      }
    }).where((combined) => combined != null).cast<AppointmentCardModel>().toList();
    return combinedList;
  }

}