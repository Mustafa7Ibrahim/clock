import 'package:clock/theme/current_theme.dart';
import 'package:clock/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/analog_clock.dart';
import 'components/date.dart';
import 'components/digital_clock.dart';

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buildSettingButton(context),
        actions: [
          CircleButton(
            icon: Icons.add,
            iconSize: 28.0,
            onTap: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Date(),
          const SizedBox(height: 12.0),
          DigitalClock(),
          const SizedBox(height: 12.0),
          Stack(
            alignment: Alignment.center,
            children: [
              AnalogClock(),
              Positioned(
                  top: 34,
                  child: Consumer<CurrentTheme>(
                    builder: (context, theme, child) {
                      return IconButton(
                        icon: Icon(
                          theme.isLightTheme ? Icons.wb_sunny : Icons.brightness_3,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => theme.changeTheme(),
                      );
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }

  IconButton buildSettingButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.more_horiz,
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: () {},
    );
  }
}
