import 'package:clock/constant/theme_colors.dart';
import 'package:clock/services/timer_service.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timerService.isRunning
              ? FloatingActionButton(
                  child: Icon(Icons.stop, color: Colors.white),
                  elevation: 0.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: timerService.stop,
                )
              : SizedBox(),
          timerService.isRunning ? SizedBox(width: 18.0) : SizedBox(),
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            child: AnimatedIcon(
              size: 28.0,
              icon: AnimatedIcons.pause_play,
              progress: _animationController,
              color: Colors.white,
            ),
            onPressed: () {
              !timerService.isRunning ? timerService.start() : timerService.pouse();
              setState(() {
                play ? _animationController.forward() : _animationController.reverse();
                play = !play;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: AnimatedBuilder(
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
      ),
    );
  }
}
