import 'package:f_medi_minders/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

// ✅ Import notification service
import 'services/notification_service.dart';

Future<void> main() async {
  // ✅ Ensure Flutter is fully initialized before any plugins run
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize notification service (local notifications, timezone setup)
  await NotificationService.init();

  // ✅ Run app with DevicePreview for easier testing on multiple devices
  runApp(
    DevicePreview(
      enabled: true, // set to false for production
      builder: (_) => const MediMinderApp(),
    ),
  );
  //runApp(const MediMinderApp());
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
