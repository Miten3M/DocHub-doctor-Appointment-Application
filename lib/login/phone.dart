import 'package:doc_hub/Repository/user_repo.dart';
import 'package:doc_hub/controllers/signup_controller.dart';
import 'package:doc_hub/login/doctor_page.dart';
import 'package:doc_hub/login/verify.dart';
import 'package:doc_hub/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:doc_hub/components/square_tile.dart';
// import 'package:csc_picker/csc_picker.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key, this.onTap}) : super(key: key);
  final Function()? onTap;
  static String verify = "";


  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  var phone = "";


  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fnameController = TextEditingController();
  final userRepo=Get.put(UserRepository());

  FirebaseAuth auth = FirebaseAuth.instance;
  // sign user in method

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(SignUpController());
    final _formkey=GlobalKey<FormState>();

    return Scaffold(

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Welcome To DocHub',
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/pageimages/doctor.png',
                    width: 300,
                    height: 100,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Get On Board!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create your profile ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    controller: controller.fullName,
                    decoration: InputDecoration(label:Text("Full Name"),prefixIcon: Icon(LineAwesomeIcons.user),border: OutlineInputBorder(borderRadius:BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.email ,
                    decoration: InputDecoration(label:Text("Email"),prefixIcon: Icon(LineAwesomeIcons.mail_bulk),border: OutlineInputBorder(borderRadius:BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),

                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: countryController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextFormField(
                          onChanged: (value) {
                            phone = value;
                          },
                          style: TextStyle(letterSpacing: 1.3),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                              controller: controller.phoneNo,
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.password,
                    decoration: InputDecoration(label:Text("Password"),prefixIcon: Icon(LineAwesomeIcons.user_shield),border: OutlineInputBorder(borderRadius:BorderRadius.circular(10))),
                  ),



                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: ()  {
                          // await FirebaseAuth.instance.verifyPhoneNumber(
                          //   phoneNumber: '${countryController.text + phone}',
                          //   verificationCompleted:
                          //       (PhoneAuthCredential credential) {}
                          //   verificationFailed: (FirebaseAuthException e) {},
                          //   codeSent: (String verificationId, int? resendToken) {
                          //     MyPhone.verify = verificationId;
                          //     Get.to(()=>const MyVerify());
                          //     FirebaseAuth.instance.createUserWithEmailAndPassword(
                          //       email: emailController.text,
                          //       password: passwordController.text,
                          //     );
                          //   },
                          //   codeAutoRetrievalTimeout: (String verificationId) {},
                          // );
                          final user = UserModel(
                            // id: auth.currentUser!.uid,
                              email: controller.email.text.trim(),
                              fullName: controller.fullName.text.trim(),
                              phoneNo:controller.phoneNo.text.trim(),
                              password: controller.password.text.trim());

                          if(_formkey.currentState!.validate()){
                            userRepo.createUser(user);
                            SignUpController.instance.phoneAuthentication('${countryController.text + phone}');
                            SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());


                            Get.to(()=> const MyVerify());
                          }
                        },
                        child: Text("Send the code")),
                  ),
                  const SizedBox(height: 30),
                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // google + apple sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button

                      SquareTile(
                        imagePath: 'assets/pageimages/google.png',
                        onTap: () {
                          signInWithGoogle();
                        },
                      ),

                      SizedBox(width: 25),

                      // apple button
                      SquareTile(
                        imagePath: 'assets/pageimages/apple.png',
                        onTap: () {},
                      )
                    ],
                  ),

                  const SizedBox(height: 25),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'For Doctor',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: ()=>Get.to(DocterPage()),
                        child: const Text(
                          'Click Here',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }
}
