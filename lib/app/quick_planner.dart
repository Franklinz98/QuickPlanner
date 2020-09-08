import 'package:app/constants/colors.dart';
import 'package:app/views/routes/authentication.dart';
import 'package:app/views/routes/main.dart';
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
        primaryColor: QuickPlannerColors.dark_salmon,
        cursorColor: QuickPlannerColors.dark_salmon,
      ),
      darkTheme: ThemeData.dark().copyWith(
        accentColor: QuickPlannerColors.burnt_sienna,
        cursorColor: QuickPlannerColors.burnt_sienna,
      ),
      home: Main(),
    );
  }
}
