import 'package:flutter/material.dart';
import 'package:clock/constant/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool start = true;
  String timetodisplay = "";
  int timefortimer;
  Timer timer;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void timerstart() {
    timefortimer = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(Duration(seconds: 1), onTick);
  }

  void onTick(Timer t) {
    setState(() {
      start = false;
      timer = t;

      if (timefortimer < 1)
        timerstop(timer);
      else
        displayTimer();
    });
  }

  void displayTimer() {
    int h = timefortimer ~/ 3600;
    int t = timefortimer - (3600 * h);
    int m = t ~/ 60;
    int s = t - (60 * m);
    timetodisplay =
        '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    timefortimer = timefortimer - 1;
  }

  void timerstop(Timer t) {
    setState(() {
      t.cancel();
      hour = 0;
      min = 0;
      sec = 0;
      start = true;
      timetodisplay = "";
      timefortimer = 0;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildStartStopButton(context),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                color: kShadowColor.withOpacity(0.14),
                blurRadius: 38,
              ),
            ],
          ),
          width: 300,
          height: 300,
          child: start == false
              ? Center(child: Text(timetodisplay, style: Theme.of(context).textTheme.headline2))
              : buildNumperPicker(),
        ),
      ),
    );
  }

  buildStartStopButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        start ? Icons.play_arrow : Icons.stop,
        color: Colors.white,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0.0,
      onPressed: () => start ? timerstart() : timerstop(timer),
    );
  }

  buildNumperPicker() {
    return Row(
      children: [
        NumberPicker.integer(
          initialValue: hour,
          minValue: 0,
          maxValue: 23,
          haptics: true,
          highlightSelectedValue: true,
          infiniteLoop: true,
          zeroPad: true,
          onChanged: (val) => setState(() => hour = val),
        ),
        NumberPicker.integer(
          initialValue: min,
          minValue: 0,
          maxValue: 59,
          haptics: true,
          highlightSelectedValue: true,
          infiniteLoop: true,
          zeroPad: true,
          onChanged: (val) => setState(() => min = val),
        ),
        NumberPicker.integer(
          initialValue: sec,
          minValue: 0,
          maxValue: 59,
          haptics: true,
          highlightSelectedValue: true,
          infiniteLoop: true,
          zeroPad: true,
          onChanged: (val) => setState(() => sec = val),
        ),
      ],
    );
  }
}
