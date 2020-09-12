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
  //Duration time = new Duration();
  //int selectitem = 1;

  int hour = 0;
  int min = 0;
  int sec = 0;
  bool start = true;
  bool stop = true;
  String timetodisplay = "";
  int timefortimer;
  final dur = const Duration(seconds: 1);

  @override
  void timerstart() {
    setState(() {
      start = false;
      stop = false;
    });
    timefortimer = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(dur, (Timer t) {
      setState(() {
        if (timefortimer < 1) {
          t.cancel();
        } else if (timefortimer < 60) {
          timetodisplay = timefortimer.toString();
          timefortimer = timefortimer - 1;
        } else if (timefortimer < 3600) {
          int m = timefortimer ~/ 60;
          int s = timefortimer - (60 * m);
          timetodisplay = m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        } else {
          int h = timefortimer ~/ 3600;
          int t = timefortimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timetodisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        }
      });
    });
  }

  void timerstop() {
    setState(() {
      start = true;
      stop = true;
      timetodisplay = "";
      timefortimer = 0;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
            child: Center(
              child: start == false
                  ? Text(
                      timetodisplay,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Row(
                      children: [
                        NumberPicker.integer(
                            initialValue: hour,
                            minValue: 0,
                            maxValue: 23,
                            onChanged: (val) {
                              setState(() {
                                hour = val;
                              });
                            }),
                        NumberPicker.integer(
                            initialValue: min,
                            minValue: 0,
                            maxValue: 59,
                            onChanged: (val) {
                              setState(() {
                                min = val;
                              });
                            }),
                        NumberPicker.integer(
                            initialValue: sec,
                            minValue: 0,
                            maxValue: 59,
                            onChanged: (val) {
                              setState(() {
                                sec = val;
                              });
                            }),
                        //Todo I cannot assign a value to a variable
                        /* Expanded(
                          child: CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hms,
                            minuteInterval: 1,
                            secondInterval: 1,
                            initialTimerDuration: time,
                            onTimerDurationChanged: (Duration changedtimer) {
                              setState(() {
                                time = changedtimer;
                              });
                            },
                          ),
                        )*/
                      ],
                    ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white)),
                  onPressed: start ? timerstart : null,
                  color: Colors.pink[200],
                  child: Text(
                    'Start',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.0, vertical: 12.0),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.white)),
                  onPressed: stop ? null : timerstop,
                  color: Colors.pink[200],
                  child: Text(
                    'Stop',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.0, vertical: 12.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
