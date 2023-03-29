import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/Repository/doctor_detail_repo.dart';
import 'package:doc_hub/Repository/user_repo.dart';
import 'package:doc_hub/models/doctor.dart';
import 'package:doc_hub/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DoctorListController extends GetxController{
  static DoctorListController get instance => Get.find();



  final _docRepo=Get.put(DocRepository());

  Future<List<DoctorModel>> getAllDoctor()  {

      return  _docRepo.allDoctor();
  }

}