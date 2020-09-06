import 'package:clock/constant/theme_colors.dart';
import 'package:clock/services/timer_service.dart';
import 'package:clock/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Stopwatch extends StatefulWidget {
  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> with TickerProviderStateMixin {
  AnimationController _animationController;
  bool play = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _animationController.animateTo(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var timerService = Provider.of<TimerService>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: timerService,
            builder: (context, child) {
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
                child: Center(
                  child: Text(
                    '${timerService.printDuration()}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                timerService.isRunning
                    ? CircleButton(
                        icon: Icons.stop,
                        iconSize: 28.0,
                        onTap: timerService.stop,
                      )
                    : Container(),
                InkWell(
                  onTap: () {
                    !timerService.isRunning ? timerService.start() : timerService.pouse();
                    setState(() {
                      play ? _animationController.forward() : _animationController.reverse();
                      play = !play;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedIcon(
                      size: 28.0,
                      icon: AnimatedIcons.pause_play,
                      progress: _animationController,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
