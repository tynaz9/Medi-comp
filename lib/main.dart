import 'package:f_medi_minders/landing_page/landing_screen.dart';
import 'package:flutter/material.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ✅ Import notification service
import 'services/notification_service.dart';
import "Name_SetUp/name_setup_screen.dart";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications
  await NotificationService.init();

  // Check if name already saved
  final prefs = await SharedPreferences.getInstance();
  final name = prefs.getString("username");

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: name == null
          ? const NameSetupScreen()
          : const LandingPage(),
    ),
  );
}

class MediMinderApp extends StatelessWidget {
  const MediMinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      // home: LandingMainPage(),  // you can switch if needed
    );
  }
}
