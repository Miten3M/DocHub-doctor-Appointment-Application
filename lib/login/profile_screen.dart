import 'package:doc_hub/contants/colors.dart';
import 'package:doc_hub/contants/image_string.dart';
import 'package:doc_hub/contants/text_strings.dart';
import 'package:doc_hub/login/update_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var isDark=MediaQuery.of(context).platformBrightness==Brightness.dark;
    void signUserOut() {
      FirebaseAuth.instance.signOut();
      // FirebaseAuth.instance.signInWithCredential(credential);

    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){},icon:const Icon(LineAwesomeIcons.angle_left)),
        centerTitle: true,
        title: Text(tProfile,style:TextStyle(color:Colors.black),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(isDark? LineAwesomeIcons.sun:LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
           padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                width: 120,height: 120,
                child: ClipRRect(
                     borderRadius:BorderRadius.circular(100),child: Image(image: AssetImage(profileImage))),
              ),
              const  SizedBox(height:10),
              Text(tProfileHeading,style: Theme.of(context).textTheme.headline4),
              Text(tProfileSubHeading,style: Theme.of(context).textTheme.bodyText2),
              const  SizedBox(height:20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: ()=>Get.to(()=>UpdateProfile()),
                    style: ElevatedButton.styleFrom(
                          backgroundColor: cPrimaryColor,side: BorderSide.none,shape: const StadiumBorder()),
                  child: const Text(tEditprofile,style: TextStyle(color: cDarkColor)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              ProfileMenuWidget(title: "Setting",icon: LineAwesomeIcons.cog,onPress: (){},),
              ProfileMenuWidget(title: "Billing Details",icon: LineAwesomeIcons.walking,onPress: (){},),
              ProfileMenuWidget(title: "User Management",icon: LineAwesomeIcons.user_check,onPress: (){},),
              const Divider(color: Colors.grey,),
              const SizedBox(height: 10,),
              ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: (){}),
              ProfileMenuWidget(title: "Logout", icon:LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,endIcon: false, onPress: signUserOut
                  )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon=true,
    this.textColor,

  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
    onTap:onPress ,
      leading: Container(
        width: 40,height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: cAccentColor.withOpacity(0.1),
        ),
        child: Icon(icon,color: cAccentColor),
      ),
      title: Text(title,style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing:endIcon? Container(
          width: 30,height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Icon(LineAwesomeIcons.angle_right,size:18.0,color:Colors.grey )):null,
    );
  }
}
