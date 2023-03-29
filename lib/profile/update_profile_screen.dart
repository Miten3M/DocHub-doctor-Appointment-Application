
import 'package:doc_hub/contants/image_string.dart';
import 'package:doc_hub/contants/text_strings.dart';
import 'package:doc_hub/controllers/profile_controller.dart';
import 'package:doc_hub/homepages/config.dart';
import 'package:doc_hub/models/user.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        centerTitle: true,
        title: Text(
          tEditprofile,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              print("Connetction not done");
              if (snapshot.connectionState == ConnectionState.done) {
                print("Connetction done");
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  final email = TextEditingController(text: userData.email);
                  final password =
                      TextEditingController(text: userData.password);
                  final fullName =
                      TextEditingController(text: userData.fullName);
                  final phoneNo = TextEditingController(text: userData.phoneNo);
                  return Column(
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
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Config.primaryColor,
                              ),
                              child: const Icon(LineAwesomeIcons.camera,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Form(
                          child: Column(
                        children: [
                          TextFormField(
                            controller: fullName,
                            // initialValue: userData.fullName,
                            decoration: InputDecoration(
                                label: Text(tFullName),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                prefixIcon: Icon(LineAwesomeIcons.user)),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: email,
                            // initialValue: userData.email,
                            decoration: InputDecoration(
                              label: Text(tEmail),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: phoneNo,
                            // initialValue: userData.phoneNo,
                            decoration: InputDecoration(
                                label: Text(tPhoneNumber),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                prefixIcon: Icon(LineAwesomeIcons.phone)),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: password,
                            // initialValue: userData.password,

                            obscureText: true,
                            decoration: InputDecoration(
                                label: Text(tPassword),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                prefixIcon: Icon(LineAwesomeIcons.fingerprint),
                                suffixIcon: IconButton(
                                  icon: const Icon(LineAwesomeIcons.eye_slash),
                                  onPressed: () {}
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final user = UserModel(
                                  id: userData.id,
                                    email: email.text.trim(),
                                    fullName: fullName.text.trim(),
                                    password: password.text.trim(),
                                    phoneNo: password.text.trim());
                                await controller.updateRecord(user);

                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Config.primaryColor,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder()),
                              child: const Text(tEditprofile,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich((TextSpan(
                                text: tJoined,
                                style: TextStyle(fontSize: 12),
                                children: [
                                  TextSpan(
                                      text: tJoinDate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12))
                                ],
                              ))),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.red.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none),
                                  child: const Text(tDelete)),
                            ],
                          )
                        ],
                      ))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
