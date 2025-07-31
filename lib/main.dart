import 'package:device_preview/device_preview.dart';
import 'package:f_medi_minders/landing_main_page.dart';
import 'package:f_medi_minders/mediremainder.dart';
import 'package:f_medi_minders/landing_screen.dart';
import 'package:f_medi_minders/welcome_home_screen.dart';
import 'package:flutter/material.dart';

//void main() => runApp(const BMIApp());
void main(){
  runApp(DevicePreview(builder: (_)=>BMIApp()));
}

class BMIApp extends StatelessWidget {
  const BMIApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const WelcomeHomeScreen(),
        //home:LandingMainPage(),
      );
}
