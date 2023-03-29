
import 'package:doc_hub/homepages/Main_Layout.dart';
import 'package:doc_hub/homepages/home_page.dart';
import 'package:doc_hub/login/phone.dart';
import 'package:doc_hub/login/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId=''.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const MyPhone()) : Get.offAll(() =>
        const MainLayout());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber:phoneNo,
        verificationCompleted: (credential)async{
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e){
          if(e.code=='invalid-phone-number'){
            Get.snackbar('Error', 'The provided phone number is not valid');
          }
          else{
            Get.snackbar('Error', 'Something went wrong.Try again.');
          }
        },
        codeSent: (verificationId,resendToken){
          this.verificationId.value=verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          this.verificationId.value=verificationId;
        },) ;
  }
  
  Future<bool> verifyOTP(String otp) async{
    var credentials=await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: this.verificationId.value,smsCode: otp));
    return credentials.user!=null?true:false;

  }

  Future<void> createUserWithEmailAndPassword(String email,
      String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      

      print("email"+email);
    }
    on FirebaseAuthException catch (e) {
            print("Error at email verification");
    } catch (_) {}
  }
  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
    await _auth.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }

}