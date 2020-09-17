import 'package:app/constants/colors.dart';
import 'package:app/views/routes/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuickPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Quick Planner',
      theme: ThemeData(
        primaryColor: QPColors.dark_salmon,
        cursorColor: QPColors.dark_salmon,
      ),
      darkTheme: ThemeData.dark().copyWith(
        accentColor: QPColors.burnt_sienna,
        cursorColor: QPColors.burnt_sienna,
      ),
      home: Authentication(),
    );
  }
}
