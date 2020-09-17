import 'package:app/constants/colors.dart';
import 'package:app/constants/enums.dart';
import 'package:app/models/project_preview.dart';
import 'package:app/widgets/profile_letter.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QPListTile extends StatelessWidget {
  final String title, subtitle;
  final QPState state;
  final Function onTap, onLongPress;
  final bool subtitleInitial;
  final Brightness deviceBrightness;

  const QPListTile({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.deviceBrightness,
    this.subtitleInitial = false,
    this.state,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: deviceBrightness == Brightness.light
              ? Colors.white
              : QPColors.nero,
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 3.00),
              color: Colors.black.withOpacity(0.16),
              blurRadius: 6,
            ),
          ],
        ),
        child: ListTile(
          leading: ProfileLetter(
              letter: subtitleInitial
                  ? subtitle.substring(0, 1)
                  : title.substring(0, 1),
              style: GoogleFonts.roboto(
                fontSize: 24,
                color: Colors.white,
              ),
              size: 42.0),
          title: Text(
            title,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: deviceBrightness == Brightness.dark
                  ? QPColors.gainsboro
                  : QPColors.san_juan,
            ),
          ),
          trailing: Visibility(
            visible: state != null,
            child: Icon(getIconFromState(state)),
          ),
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ),
    );
  }

  IconData getIconFromState(QPState state) {
    if (state == null) {
      return Icons.do_not_disturb;
    }
    switch (state) {
      case QPState.finished:
        return Icons.check_circle_outline;
      case QPState.onTrack:
        return Icons.cached;
      case QPState.withProblems:
        return Icons.warning;
    }
    return Icons.do_not_disturb;
  }
}
