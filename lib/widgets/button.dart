import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickPlannerButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const QuickPlannerButton(
      {Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.00,
      decoration: BoxDecoration(
        color: QPColors.burnt_sienna,
        borderRadius: BorderRadius.circular(4.00),
      ),
      child: FlatButton(
        onPressed: this.onPressed,
        child: Text(
          this.text.toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
