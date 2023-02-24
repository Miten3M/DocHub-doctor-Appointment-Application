import 'package:doc_hub/Repository/PatientRepository.dart';
import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/Repository/user_repo.dart';
import 'package:doc_hub/contants/text_strings.dart';
import 'package:doc_hub/models/patient.dart';
import 'package:doc_hub/models/user.dart';
import 'package:doc_hub/patients/patients.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientController extends GetxController{
  static PatientController get instance=>Get.find();

  final PName=TextEditingController();
  final Dob=TextEditingController();
  final PNumber=TextEditingController();
  final PEmail=TextEditingController();
  final _patientRepo =Get.put(PatientRepository());
  final _authRepo=Get.put(AuthenticationRepository());


 Future<List<PatientModel>> getAllPatient()  {
    final email=_authRepo.firebaseUser.value?.email;
    print(email);
    if(email!=null) {
      print(_patientRepo.allPatient(email));
      return  _patientRepo.allPatient(email);
    }
    else{
     return Future(() => List.empty());
    }
  }
  }
