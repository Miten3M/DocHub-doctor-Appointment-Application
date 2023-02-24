import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/homepages/Main_Layout.dart';
import 'package:doc_hub/homepages/home_page.dart';

import 'package:doc_hub/login/phone.dart';
import 'package:get/get.dart';

class OTPController extends GetxController{
  static OTPController get instance=> Get.find();

  void verifyOTP(String otp) async{
    var isVerified=await AuthenticationRepository.instance.verifyOTP(otp);
    print("Controller verified");
    isVerified? Get.offAll(() => MainLayout()) : Get.back();
    print("Controller verified");
  }
}