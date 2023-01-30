import 'package:doc_hub/contants/colors.dart';
import 'package:doc_hub/login/homepage.dart';
import 'package:doc_hub/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    // FirebaseAuth.instance.signInWithCredential(credential);

  }
  @override
  Widget build(BuildContext context) {

    final imagUrl =
        "https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000";
    return Drawer(
      child: Container(
        color: cPrimaryColor,
        child: InkWell(

          child: ListView(

            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountName: Text("Your Dashboard"),

                  accountEmail: Text(user.email!),

                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imagUrl),

                  ),
                ),
              ),
              ListTile(
                onTap: ()=>Get.to(()=>HomePage()),
                leading: Icon(CupertinoIcons.home, color: Colors.white),
                title: Text(
                  "Home",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: ()=>Get.to(()=>ProfileScreen()),
                leading:
                    Icon(CupertinoIcons.profile_circled, color: Colors.white),
                title: Text(
                  "Profile",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(

                leading:
                    Icon(CupertinoIcons.checkmark_shield, color: Colors.white),
                title: Text(
                  "Appoinments",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap:signUserOut,
                leading:
                Icon(Icons.logout, color: Colors.white),
                title: Text(
                  "Logout",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

