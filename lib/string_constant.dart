import 'package:flutter_dotenv/flutter_dotenv.dart';

class KStrings{
  static String appName = 'ebuddy';
  static String appSubTitle = 'Chat • Pay';
  static String loginTitle = 'Login';
  static String signUpTitle = 'Sign Up';
  static String stripePublishKey = dotenv.env['STRIPE_PUBLISH_KEY'] ?? '';
  static String stripePrivateKey = dotenv.env['STRIPE_PRIVATE_KEY'] ?? '';
  static String fbApiKey = dotenv.env['STRIPE_PRIVATE_KEY'] ?? '';
  static String fbAppId = dotenv.env['FIREBASE_APPID'] ?? '';
  static String fbProjectId = dotenv.env['FIREBASE_ID'] ?? '';
  static String fbSenderId = dotenv.env['FIREBASE_ID'] ?? '';

}