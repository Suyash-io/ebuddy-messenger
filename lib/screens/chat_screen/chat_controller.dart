

import 'package:ebuddy/firebase_services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../firebase_services/firestore_service.dart';

class ChatController extends GetxController {
  var docId = Get.arguments;
  final chatsStream = Rx<Stream<dynamic>>(const Stream.empty());

  TextEditingController messageTxt = TextEditingController();
  TextEditingController amountTxt = TextEditingController();

  final messagesList = <({String message,String sender})>[].obs;
  final amountFormKey = GlobalKey<FormState>();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chatsStream.value = FireDb.chatsLink(docId);
  }

  void sendTxtMessage() async {
    var messageData = {
      'message':messageTxt.text,
      'from': AuthService.user?.email
    };
    try {
      final result = await FireDb.chats.doc(docId).collection('chat').add(messageData);
      print('txtSend : ${result.id}');
      messageTxt.clear();
    }catch(e){
      print(e);
    }
  }
}