import 'package:doc_hub/controllers/profile_controller.dart';
import 'package:doc_hub/models/patient.dart';
import 'package:doc_hub/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PatientRepository extends  GetxController{
  static PatientRepository get instance=>Get.find();
  final _db=FirebaseFirestore.instance;
  final controller=Get.put(ProfileController());

  addPatient(PatientModel patient,String? uid)async
  {
    print(uid);
    await _db.collection("Users").doc(uid!).collection("Patient").add(patient.toJson()).whenComplete(
          () async=> await _db.collection("Patient").add(patient.toJson()).whenComplete(()=>Get.snackbar("Succcess", "You account has been created.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green),
          )
    )
        .catchError((error,stackTrace){
      Get.snackbar("Error", "Something went wrong.Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("ERROR-$error");
    });
  }

  Future<List<PatientModel>> allPatient(String email) async{

    final snapshot1=await _db.collection("Users").where("Email",isEqualTo: email).get();
    final userData=snapshot1.docs.map((e) => UserModel.fromSnapshot(e)).single;
    print(userData.id);
    final snapshot=await _db.collection("Users").doc(userData.id).collection("Patient").get();
    final patientData=snapshot.docs.map((e) => PatientModel.fromSnapshot(e)).toList();
    return patientData;
  }
}
