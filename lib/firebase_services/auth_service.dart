

import 'package:ebuddy/firebase_services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;
  static final user = FirebaseAuth.instance.currentUser;

  static Future<String> createUser(String userName,String emailId,String pass) async {
    String result = '';
    try {
      final userCreds = await auth.createUserWithEmailAndPassword(
        email: emailId,
        password: pass,
      );
      userCreds.user?.updateProfile(displayName:userName );
      result = 'successful';

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result = e.code;

      } else if (e.code == 'email-already-in-use') {
        result = e.message?? 'failed';
      }
    } catch (e) {
      print(e);
      result = e.toString();
    }
    return result;
  }

  static Future<String> login(String emailId,String pass) async {
    String result = '';
    try{
      final userCred = await auth.signInWithEmailAndPassword(email: emailId, password: pass);
        print(userCred.user?.uid);
        FireDb.newUser(userCred.user);
      result = 'successful';
    } on FirebaseAuthException catch(e){
      if(e.code == 'INVALID_LOGIN_CREDENTIALS'){
        result = e.message?? 'enter valid login credentials';
      }
    }
    catch(e){
      result = e.toString();
    }

    return result;
  }






}