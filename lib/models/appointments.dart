import 'package:cloud_firestore/cloud_firestore.dart';
class AppointmentModel {
  final String? id;
  final String p_id;
  final String doc_id;
  final String date;
  final String time;
  final String day;
  final String status;


  const AppointmentModel({
    this.id,
    required this.p_id,
    required this.doc_id,
    required this.date,
    required this.time,
    required this.day,
    this.status="upcoming"
  });
  toJson() {
    return {
      "p_id":p_id,
      "doc_id": doc_id,
      "date": date,
      "time": time,
      "day": day,
      "status":status
    };
  }
  factory AppointmentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AppointmentModel(p_id: data["p_id"], doc_id: data["doc_id"], date:  data["date"], time:  data["time"], day:  data["day"],status: data["status"]);


  }
}