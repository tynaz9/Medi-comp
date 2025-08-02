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

            // 🔘 Show Instant Notification
            ElevatedButton(
              onPressed: () {
                NotificationService.showInstantNotification();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ Instant notification sent")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: const Text("🔔 Show Instant Notification",
                  style: TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 15),

            // 🔘 Schedule Test Notification (5 sec)
            ElevatedButton(
              onPressed: () {
                //NotificationService.scheduleTestNotification();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ Notification scheduled for 5 sec later")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: const Text("⏱ Schedule Test Notification (5 sec)",
                  style: TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 15),

            // 🔘 Schedule Real Reminder (1 min later)
            ElevatedButton(
              onPressed: () {
                NotificationService.scheduleNotification(
                  id: 2,
                  title: "💊 Medicine Reminder",
                  body: "It's time to take your pill!",
                  scheduledDate: DateTime.now().add(const Duration(minutes: 1)),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ Reminder set for 1 minute later")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: const Text("💊 Schedule Medicine Reminder (1 min)",
                  style: TextStyle(fontSize: 16)),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    //NotificationService.fakeScheduledNotification();
  },
  child: const Icon(Icons.alarm),
),

    );
  }
}
