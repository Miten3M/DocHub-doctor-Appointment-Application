import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/Repository/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();
  final _authRepo=Get.put(AuthenticationRepository());
  final _userRepo=Get.put(UserRepository());
  getUserData(){
    final email=_authRepo.firebaseUser.value?.email;
    if(email!=null)
      {
        return _userRepo.getUserDetail(email);

      }else{
      Get.snackbar("Eroor", "Login to continue");
    }
  }
}