import 'dart:async';

import 'package:flutter/material.dart';

class DigitalClock extends StatefulWidget {
  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _timeOfDay = TimeOfDay.now();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _period = _timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${_timeOfDay.hour.toString().padLeft(2, '0')}:${_timeOfDay.minute.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(width: 4.0),
        RotatedBox(
          quarterTurns: 3,
          child: Text(_period),
        ),
      ],
    );
  }
}
