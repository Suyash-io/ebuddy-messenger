import 'package:ebuddy/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/dollar-money.jpg'),
                    fit: BoxFit.fill)),
          ),
         Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
              SizedBox(
                height: size.height * 0.09,
              ),
             Text(KStrings.appName,textAlign: TextAlign.center,style:GoogleFonts.syncopate(
               fontSize: 35,
               fontWeight: FontWeight.w900,
               color: const Color(0xFF38419D)
             ),),
             Text(KStrings.appSubTitle,textAlign: TextAlign.center,style:GoogleFonts.syncopate(
                 fontSize: 20,
                 fontWeight: FontWeight.w700,
                 color: const Color(0xFF38419D)
             ),),

           ],
         )
      
      
      
        ],
      ),
    );
  }
}
