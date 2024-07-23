import 'package:ebuddy/firebase_services/auth_service.dart';
import 'package:ebuddy/firebase_services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // checkUid();
    liveUser();
  }
  final userList = <({String displayName, String email})>[].obs;
  void liveUser() {
    try {
      FireDb.users.snapshots().listen((user) {
        final data = user.docs;
        for(var user in data){
          if(userList.any((item)=> item.email != user.data()['emailId']) || userList.isEmpty){
            userList.add((displayName: user.data()['displayName'],email: user.data()['emailId']));
          }
          print(user.data());
        }
        print('userList : $userList');
      });

    }catch(e){
    print('error $e');
    }
  }
  // void checkUid() async {
  //   String result = await FireDb.getUid('test@123.com');
  //   print(result);
  // }
  TextEditingController newChatTxt = TextEditingController();

  final newChatSpinner = false.obs;

  final newChatFormKey = GlobalKey<FormState>();

  final chats = <({String text,String id})>[].obs;

  final selectedVal = Rx<String?>(null);

  final searchTxt = TextEditingController();
  
  Future<String> createNewChat() async{
    String result = '';
    newChatSpinner.value = true;
    try{
      var newChat ={
        'chatRoomName': newChatTxt.text,
        'createdBy': AuthService.user?.email,
        'with': selectedVal.value
      };

      result = await FireDb.newChat(newChat);

    }catch(e){
      print(e);
      result =e.toString();
    }
    return result;
  }


}

