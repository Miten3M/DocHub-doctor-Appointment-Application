import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doc_hub/widges/drawer.dart';

class HomePage extends StatelessWidget {
  String project = "Doctor Appoinment System";
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.deepPurple[600],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
        title: Text("Doctor Booking Appoinment"),
      ),
      body: Center(
          child: Text(
            "LOGGED IN AS: " + user.email!,
            style: TextStyle(fontSize: 20),
          )
      ),
      drawer: MyDrawer(),
    );
  }
}


