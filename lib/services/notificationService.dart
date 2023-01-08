import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
class NotificationService{
  static final NotificationService  _notificationService=NotificationService._internal();

  factory NotificationService(){
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async{
    final AndroidInitializationSettings initializationSettingsAndroid=
    AndroidInitializationSettings("@drawable/launcher_icon.png");
    final IOSInitializationSettings iosInitializationSettings=
    IOSInitializationSettings(
      requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false);

    final InitializationSettings initializationSettings=InitializationSettings(
      android: initializationSettingsAndroid,
    iOS:iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  }

  Future<void> showNotification(int id,String title,String body,int seconds)async
{
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
     title, 
     body,
    tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)), 
      const NotificationDetails(
        android: AndroidNotificationDetails("E-sugu_channel", "e-SUGU", "e-SUGU Channel notification"),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true
        )
      ), 
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, 
      androidAllowWhileIdle: true);
}
}
