import 'package:app/constants/colors.dart';
import 'package:app/views/screens/main/home.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main>{
  Brightness _brightnessValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _brightnessValue ??= MediaQuery.of(context).platformBrightness;
    print('state updated');
    return Scaffold(
      body: SafeArea(child: Home()),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: QuickPlannerColors.burnt_sienna,
          elevation: 0,
          onPressed: () {
            setState(() {});
          }),
    );
  }

}
