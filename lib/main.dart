import 'package:clock/screens/wrapper/wrapper.dart';
import 'package:clock/services/timer_service.dart';
import 'package:clock/theme/current_theme.dart';
import 'package:clock/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentTheme>(create: (context) => CurrentTheme()),
        ChangeNotifierProvider<TimerService>(create: (context) => TimerService())
      ],
      builder: (context, child) {
        return Consumer<CurrentTheme>(
          builder: (context, theme, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Clock',
              theme: themeData(context),
              darkTheme: darkThemeData(context),
              themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
              home: Wrapper(),
            );
          },
        );
      },
    );
  }
}
