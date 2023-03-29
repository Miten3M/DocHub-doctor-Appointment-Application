import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_hub/models/doctor.dart';
import 'package:get/get.dart';
// import 'package:flutter/material.dart';

class DocRepository extends GetxController {
  static DocRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<DoctorModel> getDoctorDetail(String name) async {
    print("doc repo");
    print("doc $name");
    final snapshot = await _db.collection("Doctor")
        .where("DoctorName", isEqualTo:name )
        .get();
    final docData = snapshot.docs
        .map((e) => DoctorModel.fromSnapshot(e))
        .single;
    print(docData.id);
    return docData;
  }
  Future<List<DoctorModel>> allDoctor() async{


    final snapshot=await _db.collection("Doctor").get();
    final docData=snapshot.docs.map((e) => DoctorModel.fromSnapshot(e)).toList();
    return docData;
  }
}
