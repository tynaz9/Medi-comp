import 'package:flutter/material.dart';
import 'services/notification_service.dart';

class NotificationTestScreen extends StatelessWidget {
  const NotificationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🔔 Notification Tester"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Tap a button to test notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // 🔘 Instant Notification
            ElevatedButton(
              onPressed: () {
                NotificationService.showInstantNotification();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("✅ Instant notification sent"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: const Text(
                "🔔 Show Instant Notification",
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            // 🔘 Schedule Test Reminder (1 min later)
            ElevatedButton(
              onPressed: () {
                NotificationService.scheduleNotification(
                  id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                  medicineName: "Paracetamol",
                  doseInfo: "1 dose - Tablets",
                  scheduledDate:
                      DateTime.now().add(const Duration(minutes: 1)),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("✅ Medicine reminder scheduled (1 minute later)"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: const Text(
                "💊 Schedule Medicine Reminder (1 min)",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NotificationService.showInstantNotification();
        },
        child: const Icon(Icons.alarm),
),
    );
  }
}