import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// ✅ Initialize notifications
  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit);

    await _notificationsPlugin.initialize(initSettings);

    // ✅ Request permission for Android 13+
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  /// 🔔 Show an instant reminder notification
  static Future<void> showInstantNotification() async {
    await _notificationsPlugin.show(
      1,
      "💊 Take Your Medicine",
      "It's time for your dose! Stay healthy! 🩺",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_channel',
          'Instant Notifications',
          channelDescription: 'Shows notifications instantly',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }

  /// ⏱ Schedule a reminder for later
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_channel',
          'Scheduled Notifications',
          channelDescription: 'Medicine reminders for scheduled times',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// 🔥 Fired (simulated medicine reminder alarm)
  static Future<void> fireReminderNotification() async {
    await _notificationsPlugin.show(
      2,
      "🚨 Medicine Reminder",
      "Your alarm is ringing! Take your pill NOW! 💊",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'fired_channel',
          'Medicine Alarm',
          channelDescription: 'Loud alarm-style medicine reminder',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          enableVibration: true,
          fullScreenIntent: true,
        ),
      ),
    );
  }
}
