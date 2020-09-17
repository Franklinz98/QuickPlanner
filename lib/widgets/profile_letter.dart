import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileLetter extends StatelessWidget {
  final String letter;
  final double size;
  final TextStyle style;

  const ProfileLetter({
    Key key,
    @required this.letter,
    @required this.style,
    @required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: QPColors.dark_salmon,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          letter,
          style: style,
        ),
      ],
    );
  }
}
