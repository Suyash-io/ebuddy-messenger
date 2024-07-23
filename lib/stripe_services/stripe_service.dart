import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ebuddy/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

final dio = Dio();

class StripeService {

  static final stripe = Stripe.instance;

  static Future<void> initPaySheet(String amt) async {
    try {
      String response = await _createTestPaymentSheet(amt);

      var data  = jsonDecode(response);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Content Shark',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          // Extra options
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}

Future<String> _createTestPaymentSheet(String amt) async {
  String result = '';
  try {
    amt = (int.parse(amt) *100).toString();
    var data = {
      "amount": amt,
      "currency": "usd",
      "automatic_payment_methods[enabled]": true
    };
    print('PRIVATE KEY = ${KStrings.stripePrivateKey}');
    final response = await dio.post('https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(headers: {
          "authorization": "Bearer ${KStrings.stripePrivateKey}",
          "Content-Type":"application/x-www-form-urlencoded"
        }));
    if(response.statusCode == 200) {
      return response.toString();
    }
  } catch (e) {
    print(e);
    result = e.toString();
  }
  return result;
}
