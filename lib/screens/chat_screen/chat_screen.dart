import 'package:ebuddy/firebase_services/auth_service.dart';
import 'package:ebuddy/screens/chat_screen/chat_controller.dart';
import 'package:ebuddy/screens/chat_screen/message_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatC = Get.put(ChatController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nick'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
                stream: chatC.chatsStream.value,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    chatC.messagesList.clear();
                    return const Expanded(
                        child: Center(
                            child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    )));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!.docs;
                    chatC.messagesList.clear();
                    for (final chat in data) {
                      chatC.messagesList.add((
                        sender: chat.data()['from'],
                        message: chat.data()['message']
                      ));
                    }
                    return data.isEmpty
                        ? const Spacer()
                        : Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return MessageBubble(sender: chatC.messagesList[index].sender, text: chatC.messagesList[index].message, isMe: chatC.messagesList[index].sender == AuthService.user?.email);
                              },
                              itemCount: chatC.messagesList.length,
                              shrinkWrap: true,
                            ),
                          );
                  } else {
                    chatC.messagesList.clear();
                    return const Spacer();
                  }
                }),
            Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: KWidgets.textField(
                          txtController: chatC.messageTxt,
                          hintText: 'message')),

                  IconButton(
                      onPressed: () async => amountModal(context,chatC ),
                      icon: const Icon(CupertinoIcons.money_dollar)),
                  IconButton(
                      onPressed: () {
                        if (chatC.messageTxt.text.isNotEmpty) {
                          chatC.sendTxtMessage();
                        }
                      },
                      icon: const Icon(Icons.send)),
                ],
              ),
            )
          ],
        ));
  }
}
