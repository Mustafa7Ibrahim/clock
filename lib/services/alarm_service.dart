import 'package:clock/models/alarm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnLable = 'lable';
final String columnDateTime = 'dateTime';
final String columnEnable = 'enable';
final String columnDays = 'days';

class AlarmService extends ChangeNotifier {
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + 'alarm.db';

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnLable text not null,
          $columnDateTime text not null,
          $columnEnable integer not null,
          $columnDays array)
        ''');
      },
    );
    return database;
  }

  void insertAlarm(AlarmModel alarmModel) async {
    var db = await this.database;
    var result = await db.insert(tableAlarm, alarmModel.tojson());
    notifyListeners();
    print(result);
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    var deletResult = await db.delete(
      tableAlarm,
      where: '$columnId =?',
      whereArgs: [id],
    );
    notifyListeners();
    return deletResult;
  }

  Future<List<AlarmModel>> getAlarms() async {
    List<AlarmModel> alarms = [];
    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmData = AlarmModel.fromJson(element);
      alarms.add(alarmData);
    });

    return alarms;
  }

  void setAlarm(DateTime _alarmTime) {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmModel(
      dateTime: scheduleAlarmDateTime,
      lable: 'Alarm',
      enable: true,
    );
    insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    notifyListeners();
  }

  void setTime(BuildContext context) async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      final now = DateTime.now();
      var selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      setAlarm(selectedDateTime);
    }
  }

  void scheduleAlarm(DateTime scheduledNotificationDateTime, AlarmModel alarmModel) async {
    final String time = DateFormat.jm().format(alarmModel.dateTime);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'clock',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alarm'),
      largeIcon: DrawableResourceAndroidBitmap('clock'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'alarm.mp3',
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
      alarmModel.lable,
      time,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
    );
  }
}
