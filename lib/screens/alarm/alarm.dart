import 'package:clock/constant/theme_colors.dart';
import 'package:clock/models/alarm_model.dart';
import 'package:clock/services/alarm_db.dart';
import 'package:clock/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  DateTime _alarmTime;
  AlarmDB _alarmDB = AlarmDB();
  Stream<List<AlarmModel>> _alarms;
  String _alarmTimeString;
  @override
  void initState() {
    _alarmDB.initializeDatabase().then((value) => loadAlarms());
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmDB.getAlarms().asStream();
    if (mounted) setState(() {});
  }

  void setAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmModel(
      dateTime: scheduleAlarmDateTime,
      lable: 'alarm',
      enable: true,
    );
    _alarmDB.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime);
    Navigator.pop(context);
    loadAlarms();
  }

  void setTime() async {
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
      _alarmTime = selectedDateTime;

      setState(() => _alarmTimeString = DateFormat.jm().format(selectedDateTime));
    }
  }

  void showButtomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      clipBehavior: Clip.antiAlias,
      useRootNavigator: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(32.0),
              child: Column(
                children: [
                  FlatButton(
                    onPressed: setTime,
                    child: Text(_alarmTimeString, style: TextStyle(fontSize: 32)),
                  ),
                  CheckboxListTile(
                    value: false,
                    onChanged: (onChange) {},
                    title: Text('Repeat'),
                  ),
                  TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Lable',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.label_outline),
                    ),
                  ),
                  FloatingActionButton.extended(
                    onPressed: setAlarm,
                    icon: Icon(Icons.alarm),
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text('Save'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        tooltip: 'Add alarm',
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _alarmTimeString = DateFormat.jm().format(DateTime.now());
          showButtomSheet(context);
        },
      ),
      body: StreamBuilder(
        stream: _alarms,
        builder: (context, snapshot) => snapshot.hasData
            ? ListView(
                children: snapshot.data.map<Widget>(
                  (alarm) {
                    var alarmTime = DateFormat('hh:mm').format(alarm.dateTime);
                    var dayAndNight = DateFormat('aa').format(alarm.dateTime);
                    return Container(
                      padding: EdgeInsets.all(12.0),
                      margin: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(18.0),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            color: kShadowColor.withOpacity(0.14),
                            blurRadius: 38,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.alarm),
                              SizedBox(width: 4.0),
                              Text(
                                alarm.lable,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Spacer(),
                              Switch(
                                onChanged: (bool value) {
                                  setState(() {
                                    alarm.enable = value;
                                  });
                                },
                                activeColor: Theme.of(context).primaryColor,
                                value: alarm?.enable ?? true,
                              ),
                            ],
                          ),
                          // Row(
                          //   children: alarm.days.map((e) => Text('$e, ')).toList(),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                alarmTime,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                dayAndNight,
                                style: Theme.of(context).textTheme.headline3.copyWith(
                                    fontSize: 14.0, color: Theme.of(context).primaryColor),
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.delete_outline),
                                onPressed: () {},
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ).toList(),
              )
            : Container(
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
