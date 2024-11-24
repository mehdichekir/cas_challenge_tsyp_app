import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse payload) async {
          // Handle notification tap
        }
    );
  }

  Future<void> showFireNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'fire_alert',
      'Fire Alerts',
      importance: Importance.high,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('alarm'),
      enableVibration: true,
      category: AndroidNotificationCategory.alarm,
      fullScreenIntent: true,
      playSound: true
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await notificationsPlugin.show(
      0,
      'Fire Alert!',
      'Fire has been detected in your home!',
      details,
    );
  }
}
