import 'package:doc_hub/contants/image_string.dart';
import 'package:doc_hub/login/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doc_hub/widges/drawer.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  String project = "Doctor Appoinment System";
  final user = FirebaseAuth.instance.currentUser!;

 // sign user out method
  void signUserOut ()async {
    await FirebaseAuth.instance.signOut();
    // FirebaseAuth.instance.signInWithCredential(credential);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DocHub",style: TextStyle(color: Colors.black),textAlign: TextAlign.center),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20,top: 7),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) ),
            child: IconButton(onPressed:() => Get.to(()=>const ProfileScreen()),icon:Image(image: AssetImage(userProfileImage),)),

      ),]
      ),
      body:Center(
          child: Text(
            "LOGGED IN!,Welcome",
            style: TextStyle(fontSize: 20),
          )
      ),

       drawer: MyDrawer(),
    );
  }
}


