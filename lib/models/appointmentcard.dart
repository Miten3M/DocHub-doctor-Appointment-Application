import 'package:cloud_firestore/cloud_firestore.dart';
class AppointmentCardModel {
  final String? id;
  final String p_id;
  final String doc_id;
  final String date;
  final String time;
  final String day;
  final String status;
  final String doctor_name;
  final String doc_profile;
  final String category;
  final String appoint_id;



  const AppointmentCardModel( {
    this.id,
    required this.appoint_id,
    required this.doctor_name,
    required this.p_id,
    required this.doc_id,
    required this.date,
    required this.time,
    required this.day,
    required this.status,
    required this.doc_profile,
    required this.category,

  });
  toJson() {
    return {
      "appoint_id":appoint_id,
      "doctor_name":doctor_name,
      "doc_profile":status,
      "category":category,
      "p_id":p_id,
      "doc_id": doc_id,
      "date": date,
      "time": time,
      "day": day,
      "status":status
    };
  }
  factory AppointmentCardModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AppointmentCardModel(doctor_name:data["doctor_name"],
        appoint_id:data["appoint_id"],
        p_id:data["p_id"],
        doc_id:data["doc_id"] ,
        date: data["date"],
        time: data["time"],
        day: data["day"],
        status:data["status"],
        doc_profile: data["doc_profile"],
        category: data["category"]);
  }
}