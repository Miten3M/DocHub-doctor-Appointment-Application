import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/Repository/user_repo.dart';
import 'package:doc_hub/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();


  final _authRepo=Get.put(AuthenticationRepository());
  final _userRepo=Get.put(UserRepository());
  // FirebaseAuth auth = FirebaseAuth.instance;
  getUserData() async {
    // print("User email fetch");
    final email = await _authRepo.firebaseUser.value?.email;
    print(email);
    if(email!=null)
      {
        print('User email fetch 1');
        return _userRepo.getUserDetail(email);

      }else{
      Get.snackbar("Error", "Login to continue");
    }
  }
  updateRecord(UserModel user) async{
    await _userRepo.updateUserRecord(user);
  }
}