import 'package:ebuddy/screens/auth_screen/auth_controller.dart';
import 'package:ebuddy/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common_widgets.dart';
import '../../../string_constant.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key, required this.authController});
  final AuthController authController;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      color: const Color(0xFFF3F8FF),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Form(
          key: authController.loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                KStrings.loginTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.syncopate(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF38419D)),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              KWidgets.textField(
                  txtController: authController.loginEmail,
                  hintText: 'email id',
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'email Id cannot be empty';
                    }

                    return email.isValidEmail() ? null : 'enter valid email';
                  },
                  maxLength: 30),
              SizedBox(
                height: size.height * 0.02,
              ),
              KWidgets.passwordField(
                  txtController: authController.loginPass,
                  hintText: 'password',
                  validator: (pass) {
                    if (pass == null || pass.isEmpty) {
                      return 'password cannot be empty';
                    }
                    return pass.length >= 6 ? null : 'password must contain 6 char';
                  },
                  maxLength: 18, isObscure: authController.isObscure.value,iconPressed:() {
                    authController.isObscure.value = !authController.isObscure.value;
              }),
              SizedBox(
                height: size.height * 0.04,
              ),
              OutlinedButton(
                  onPressed: () async {
                    if (authController.loginFormKey.currentState!.validate()) {
                      authController.showSpinner.value = true;
                      String result = await authController.userLogin(context);
                      if (result == 'successful') {
                        Get.offAll(() => const HomeScreen());
                      } else {
                        Get.snackbar(
                            'Failed', 'something went wrong,try again');
                      }
                      authController.isObscure.value = true;
                      authController.showSpinner.value = false;
                    }
                  },
                  child: const Text('Login')),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        print('forgetClicked');
                      },
                      child: const Text(
                        'Forget Password',
                        style: TextStyle(color: Colors.grey),
                      )),
                  GestureDetector(
                      onTap: () {
                        authController.selectedIndex.value = 1;
                      },
                      child: const Text('Sing up'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
