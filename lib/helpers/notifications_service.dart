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
      },
    );
  }

  Future<void> showFireNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'fire_alert',  // channel id
      'Fire Alerts', // channel name
      channelDescription: 'Alerts for fire detection', // channel description
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('alarm'),
      playSound: true,
      enableLights: true,
      enableVibration: true,
      category: AndroidNotificationCategory.alarm,
      fullScreenIntent: true,
      ticker: 'Fire Alert',
      audioAttributesUsage: AudioAttributesUsage.alarm,
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