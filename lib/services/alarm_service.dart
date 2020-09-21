import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

void scheduleAlarm(DateTime scheduledNotificationDateTime) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'alarm_notif',
    'alarm_notif',
    'Channel for Alarm notification',
    icon: 'clock',
    largeIcon: DrawableResourceAndroidBitmap('clock'),
  );

  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics,
    iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.schedule(
    0,
    'Alarm',
    'It\'s Time',
    scheduledNotificationDateTime,
    platformChannelSpecifics,
  );
}
