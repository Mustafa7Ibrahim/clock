import 'package:clock/constant/theme_colors.dart';
import 'package:clock/models/alarm_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  List<AlarmModel> alarms = <AlarmModel>[
    AlarmModel(
      dataTime: DateTime.now(),
      enable: false,
      id: '21551',
      lable: 'Lable',
      days: ['Mon', 'day', 'sun'],
    ),
    AlarmModel(
      dataTime: DateTime.now(),
      enable: false,
      id: '21551',
      lable: 'WORK',
      days: ['Mon', 'day'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        tooltip: 'Add alarm',
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      body: ListView(
        children: alarms.map((alarm) {
          var alarmTime = DateFormat('hh:mm').format(alarm.dataTime);
          var am_pm = DateFormat('aa').format(alarm.dataTime);
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
                      value: alarm.enable,
                    ),
                  ],
                ),
                Row(
                  children: alarm.days.map((e) => Text('$e, ')).toList(),
                ),
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
                      am_pm,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 14.0, color: Theme.of(context).primaryColor),
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
        }).toList(),
      ),
    );
  }
}
