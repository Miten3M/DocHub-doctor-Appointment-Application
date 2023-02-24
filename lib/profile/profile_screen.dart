import 'package:doc_hub/Repository/authentication_repo.dart';
import 'package:doc_hub/contants/colors.dart';
import 'package:doc_hub/contants/image_string.dart';
import 'package:doc_hub/contants/text_strings.dart';
import 'package:doc_hub/homepages/Main_Layout.dart';
import 'package:doc_hub/homepages/home_page.dart';

import 'package:doc_hub/patients/patients.dart';
import 'package:doc_hub/profile/update_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';

import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void signUserOut() async {
      // await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();

    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tProfile,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage(userProfileImage))),
                  ),
                  Positioned(
                    bottom:0,
                    right: 0,
                    child:Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: cPrimaryColor,
                      ),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size:20
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Your Profile",
                  style: Theme.of(context).textTheme.headline4),
              Text("Wellcome!!",
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfile()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: cPrimaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(tEditprofile,
                      style: TextStyle(color: cDarkColor)),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: "Patients",
                icon: LineAwesomeIcons.cog,
                onPress: () {Get.to(()=>Patient());},
              ),
              ProfileMenuWidget(
                title: "Billing Details",
                icon: LineAwesomeIcons.walking,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: "User Management",
                icon: LineAwesomeIcons.user_check,
                onPress: () {},
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                  title: "Information",
                  icon: LineAwesomeIcons.info,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: signUserOut)
            ],
          ),
        ),
      ),
    );
  }
}
