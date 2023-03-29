import 'package:doc_hub/Repository/appointment_repo.dart';
import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/Repository/doctor_detail_repo.dart';
import 'package:doc_hub/Repository/user_repo.dart';
import 'package:doc_hub/controllers/profile_controller.dart';
import 'package:doc_hub/models/appointmentcard.dart';
import 'package:doc_hub/models/appointments.dart';
import 'package:doc_hub/models/doctor.dart';
import 'package:doc_hub/models/user.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AppointmentController extends GetxController {
  static AppointmentController get instance => Get.find();
  final _authRepo=Get.put(AuthenticationRepository());
  final _appointRepo = Get.put(AppointmentRepository());
  Future<List<AppointmentCardModel>> getAllAppointment() async {
    final email = await _authRepo.firebaseUser.value?.email;
    print(email);
    if(email!=null)
    {
      print('User email fetch 1');
      return _appointRepo.getAppointment(email);

    }else{
      return Future(() => List.empty());
    }
  }

  void cancelAppointment(AppointmentModel appoint,String appoint_id, String p) async{
    final email = await _authRepo.firebaseUser.value?.email;
    print(email);
    if(email!=null)
    {
      print('User email fetch 1');
      return _appointRepo.updateAppointmentRecord(appoint, email,p ,appoint_id );

    }else{
      return Future(() => List.empty());
    }
  }


  }

