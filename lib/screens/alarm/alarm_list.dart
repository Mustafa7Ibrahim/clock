import 'package:clock/constant/theme_colors.dart';
import 'package:clock/models/alarm_model.dart';
import 'package:clock/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmsList extends StatefulWidget {
  const AlarmsList({@required this.alarm, @required this.alarmService});

  final List<AlarmModel> alarm;
  final AlarmService alarmService;

  @override
  _AlarmsListState createState() => _AlarmsListState();
}

class _AlarmsListState extends State<AlarmsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.alarm.length,
      itemBuilder: (context, index) {
        var alarmTime = DateFormat('hh:mm').format(widget.alarm[index].dateTime);
        var dayAndNight = DateFormat('aa').format(widget.alarm[index].dateTime);
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
                    widget.alarm[index].lable,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Spacer(),
                  Switch(
                    onChanged: (bool value) {
                      setState(() => widget.alarm.elementAt(index).enable = value);
                    },
                    activeColor: Theme.of(context).primaryColor,
                    value: widget.alarm[index]?.enable ?? true,
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
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontSize: 14.0, color: Theme.of(context).primaryColor),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () => widget.alarmService.delete(widget.alarm[index].id),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
