import 'package:clock/models/alarm_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = 'alarm';
final String columnId = 'id';
final String columnLable = 'lable';
final String columnDateTime = 'dateTime';
final String columnEnable = 'enable';
final String columnDays = 'days';

class AlarmDB extends ChangeNotifier {
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
}
