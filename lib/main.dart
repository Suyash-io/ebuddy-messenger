import 'package:ebuddy/screens/auth_screen/auth_screen.dart';
import 'package:ebuddy/screens/home_screen/home_screen.dart';
import 'package:ebuddy/screens/userTemp.dart';
import 'package:ebuddy/string_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = KStrings.stripePublishKey;
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: KStrings.fbApiKey, appId: KStrings.fbAppId, messagingSenderId: KStrings.fbSenderId, projectId: KStrings.fbProjectId)
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      title: 'Ebuddy',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.montserrat(textStyle: textTheme.bodyMedium),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD2DAFF)),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}






// import 'package:firebase_local/firebase_local.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String _platformVersion = 'Unknown';
//   String _battery = '';
//   final _firebaseLocalPlugin = FirebaseLocal();
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//     try {
//       platformVersion = await _firebaseLocalPlugin.getPlatformVersion() ?? 'Unknown platform version';
//       _battery = await _firebaseLocalPlugin.getBattery()?? 'Not found';
//       final result = await _firebaseLocalPlugin.getUid('test123@gmail.com');
//       print(result);
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               'Running on: $_platformVersion\n Battery : $_battery',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
