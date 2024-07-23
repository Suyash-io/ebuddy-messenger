import 'package:ebuddy/firebase_services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserCheck extends StatefulWidget {
  const UserCheck({super.key});

  @override
  State<UserCheck> createState() => _UserCheckState();
}

class _UserCheckState extends State<UserCheck> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FireDb.newUser('95xEb62UBROY8O803P1smAwbIJr1');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.red.shade100,
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
