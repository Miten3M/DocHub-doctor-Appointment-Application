import 'package:doc_hub/contants/colors.dart';
import 'package:doc_hub/contants/image_string.dart';
import 'package:doc_hub/contants/text_strings.dart';
import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage(profileImage))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: cPrimaryColor,
                      ),
                      child: const Icon(LineAwesomeIcons.camera,
                          color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Form(child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(tFullName),border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),prefixIcon: Icon(LineAwesomeIcons.user)
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(tEmail),border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(tPhoneNumber),border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),prefixIcon: Icon(LineAwesomeIcons.phone)
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(tPassword),border: OutlineInputBorder(borderRadius:BorderRadius.circular(10)),prefixIcon: Icon(LineAwesomeIcons.fingerprint)
                    ),
                  ),
                  const SizedBox(height: 40,),
                  SizedBox(
                    width: double.infinity,
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
                  const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich((TextSpan(
                        text:tJoined,
                        style:TextStyle(fontSize: 12),
                        children: [TextSpan(text: tJoinDate,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12) )],
                      ))),
                      ElevatedButton(onPressed: (){}, style:ElevatedButton.styleFrom(backgroundColor: Colors.red.withOpacity(0.1)
                      ,elevation: 0,
                        foregroundColor: Colors.red,
                        shape: const StadiumBorder(),
                        side: BorderSide.none
                      ),
                          child: const Text(tDelete)),
                    ],
                  )
                ],
              ))

            ],
          ),
        ),
      ),
    );
  }
}
