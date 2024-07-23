import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KWidgets {
  static TextFormField textField(
      {required TextEditingController txtController,
      required String hintText,
      String? Function(String?)? validator,
      TextInputType? keyboard,
      int? maxLength}) {
    return TextFormField(
      controller: txtController,
      validator: validator,
      maxLength: maxLength,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        counterText: '',
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }

  static TextFormField passwordField(
      {required TextEditingController txtController,
      required String hintText,
      required bool isObscure,
      Function()? iconPressed,
      String? Function(String?)? validator,
      int? maxLength}) {
    return TextFormField(
      obscureText: isObscure,
      controller: txtController,
      validator: validator,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        counterText: '',
        suffixIcon: IconButton(
          onPressed: iconPressed,
          icon: isObscure
              ? const Icon(CupertinoIcons.eye)
              : const Icon(CupertinoIcons.eye_slash),
        ),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }

  static SnackbarController snackAlert(
      {required String status,
      required String message,
      Duration? duration,
      SnackPosition? direction}) {
    return Get.snackbar(status, message,
        duration: duration ?? const Duration(milliseconds: 1200),
        snackPosition: direction ?? SnackPosition.BOTTOM);
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
