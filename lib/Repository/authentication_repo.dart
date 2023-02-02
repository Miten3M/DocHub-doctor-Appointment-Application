import 'package:doc_hub/login/homepage.dart';
import 'package:doc_hub/login/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instane=> Get.find();

  final _auth=FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    // TODO: implement onReady
    firebaseUser=Rx<User?>(_auth.currentUser) ;
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

  }

  _setInitialScreen(User? user) {
    user==null?Get.offAll(()=>const MyPhone()): Get.offAll(()=>HomePage());
  }

  Future<void> createUserWithEmailAndPassword(String email,String password)async{
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value!=null?Get.offAll(()=>HomePage()):Get.to(()=>MyPhone());
    }
    on FirebaseAuthException catch(e){

    }catch(_){}
    }

}