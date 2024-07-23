import 'package:ebuddy/screens/home_screen/home_components.dart';
import 'package:ebuddy/screens/home_screen/home_controller.dart';
import 'package:ebuddy/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets.dart';
import '../../firebase_services/firestore_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeC = Get.put(HomeController());
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () async => newChat(context, homeC),
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          KStrings.appName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
              stream: FireDb.chatroom,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  homeC.chats.clear();
                  return const Expanded(
                    child: Center(
                      child: SizedBox(
                       
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } 
                else if (snapshot.hasData) {
                  print('has data');
                  homeC.chats.clear();
                  final data = snapshot.data!.docs;
                  for (final chat in data) {
                    homeC.chats.add((id: chat.id,text: chat.data()['chatRoomName']));
                  }
                  print('${homeC.chats} after adding');
                  return data.isEmpty
                      ? noChats()
                      : chatsList(homeC);
                } else {
                  homeC.chats.clear();
                  return noChats();
                }
              }),
          // Container(
          //   decoration: const BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(10),
          //           topRight: Radius.circular(10))),
          //   child: Row(
          //     children: [
          //       Expanded(
          //           child: KWidgets.textField(
          //               txtController: homeC.messageTxt, hintText: 'message')),
          //       IconButton(onPressed: () {}, icon: const Icon(Icons.send))
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
