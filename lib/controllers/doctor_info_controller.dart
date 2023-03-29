import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/Repository/doctor_detail_repo.dart';
import 'package:doc_hub/Repository/user_repo.dart';
import 'package:doc_hub/models/doctor.dart';
import 'package:doc_hub/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DoctorInfoController extends GetxController{
  static DoctorInfoController get instance => Get.find();
  final _docRepo=Get.put(DocRepository());
  getDoctorDetails(String id){
    return _docRepo.getDoctorDetail(id);
  }
}
