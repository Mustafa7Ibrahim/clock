import 'dart:async';
import 'dart:math';

import 'package:clock/constant/theme_colors.dart';
import 'package:flutter/material.dart';

import 'clock_painter.dart';

class AnalogClock extends StatefulWidget {
  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(context),
        ),
      ),
    );
  }
}
