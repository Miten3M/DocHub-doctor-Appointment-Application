import 'dart:ui';

import 'package:doc_hub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UserRepository extends GetxController{
  static UserRepository get instance=>Get.find();

  final _db=FirebaseFirestore.instance;

  createUser(UserModel user)async
  {
    await _db.collection("Users").add(user.toJson()).whenComplete(
            () => Get.snackbar("Succcess", "You account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),

    )
        .catchError((error,stackTrace){
      Get.snackbar("Error", "Something went wrong.Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("ERROR-$error");
    });

  }

  Future<UserModel> getUserDetail(String email)async{
    final snapshot =await _db.collection("Users").where("Email",isEqualTo: email).get();
    final userData=snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

}