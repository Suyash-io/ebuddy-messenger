

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebuddy/firebase_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
class FireDb {
  static final db = FirebaseFirestore.instance;
  static final chatroom = db.collection('chat-rooms').where(Filter.or(Filter('createdBy',isEqualTo: AuthService.user?.email), Filter('with',isEqualTo: AuthService.user?.email))).snapshots();
  static var chats = db.collection('chat-rooms');
  static var users = db.collection('users');

  static Future<String> newChat(var data) async{
    String result = '';
    try{
      final response = await chats.add(data);
      print(response.id);
      result ='successful';
    }catch(e){
      print(e);
      result = e.toString();
    }
    return result;
  }

  static Future<String> newUser(User? user) async{
    String result = '';
    try{
      if(user!=null) {
        var data = {
          'uid':user.uid,
          'displayName': user.displayName,
          'emailId': user.email
        };
        users.where('uid',isEqualTo: user.uid).get().then((val) async {
          if(val.docs.isEmpty){
            print('empty');

            final response = await users.add(data);
            print(response.id);
            result = 'successful';
          }else{
            print('else');
          }

        });
        result ='successful';
      }

    }catch(e){
      print(e);
      result = e.toString();
    }
    return result;
  }

 static Stream<dynamic> chatsLink(String docId) {
    return db.collection('chat-rooms').doc(docId).collection('chat').snapshots();
 }


}