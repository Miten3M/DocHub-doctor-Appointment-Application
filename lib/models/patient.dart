import 'package:cloud_firestore/cloud_firestore.dart';
class PatientModel {
  final String? id;
  final String userid;
  final String patientName;
  final String age;
  final String gender;
  final String pNumber;
  final String? email;


  const PatientModel({
    this.id,
    required  this.userid,
    required this.patientName,
    required this.age,
    required this.gender,
    required this.pNumber,
    this.email,
  });

  toJson() {
    return {
      "Userid":userid,
      "PatientName": patientName,
      "Age": age,
      "Gender": gender,
      "PNumber": pNumber
    };
  }


   factory PatientModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
     final data = document.data()!;
     return PatientModel(
         id: document.id, userid:data["Userid"],patientName: data["PatientName"], age: data["Age"], gender: data["Gender"],pNumber:data["PNumber"] );


  }
 }