import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class NoProjectsImage extends StatelessWidget {
  final Brightness deviceBrightness;

  const NoProjectsImage({Key key, @required this.deviceBrightness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          "Parece que no tienes ningún\nproyecto aún...",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: deviceBrightness == Brightness.dark
                ? QPColors.gainsboro
                : QPColors.san_juan,
          ),
        ),
        deviceBrightness == Brightness.dark
            ? Image.asset('assets/images/no_project_dark.png')
            : Image.asset('assets/images/no_project.png'),
        Spacer(),
      ],
    );
  }
}
