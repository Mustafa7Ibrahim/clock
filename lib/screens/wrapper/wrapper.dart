import 'package:clock/screens/alarm/alarm.dart';
import 'package:clock/screens/clock/clock.dart';
import '../stopwatch/stopwatch.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Alarm(),
      Clock(),
      Stopwatch(),
      Scaffold(),
    ];
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        iconSize: 24.0,
        onTap: (index) => setState(() => _selectedIndex = index),
        currentIndex: _selectedIndex,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            title: Text('Alarm'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Clock'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            title: Text('Stopwatch'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title: Text('Timer'),
          ),
        ],
      ),
    );
  }
}
