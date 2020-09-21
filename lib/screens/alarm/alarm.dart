import 'package:clock/models/alarm_model.dart';
import 'package:clock/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alarm_list.dart';

class Alarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<AlarmService>(
        builder: (context, value, child) {
          return FloatingActionButton(
            elevation: 0.0,
            tooltip: 'Add alarm',
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () => value.setTime(context),
          );
        },
      ),
      body: Consumer<AlarmService>(
        builder: (context, alarmService, child) {
          return StreamBuilder(
            stream: alarmService.getAlarms().asStream(),
            builder: (context, snapshot) {
              List<AlarmModel> alarm = snapshot.data;
              return snapshot.hasData
                  ? AlarmsList(alarm: alarm, alarmService: alarmService)
                  : Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
