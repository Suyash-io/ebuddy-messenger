import 'package:ebuddy/screens/auth_screen/auth_screen.dart';
import 'package:ebuddy/firebase_services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final selectedIndex = 0.obs;
  final showSpinner = false.obs;
  final isObscure = false.obs;
  final loginFormKey = GlobalKey<FormState>();
  final signFormKey = GlobalKey<FormState>();
  final forgetPassFormKey = GlobalKey<FormState>();

  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPass = TextEditingController();

  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPass = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    showSpinner.value = false;
  }

  void checkAuth() {
    Future.delayed(const Duration(seconds: 2),
        () => {Get.offAll(() => const AuthScreen())});
  }

  Future<String> singUpUser(BuildContext context) async {
    String result = '';
    try {
      result = await AuthService.createUser(userName.text,signUpEmail.text, signUpPass.text);
    } catch (e) {
      print(e);
      result = 'failed';
    }
    print('singup finished $result');
    return result;
  }

  Future<String> userLogin(BuildContext context) async {
    String result = '';
    try {
      result = await AuthService.login(loginEmail.text, loginPass.text);
    } catch (e) {
      print(e);
      result = 'failed';
    }
    print('User Login end $result');
    return result;
  }

}
