import 'package:app/backend/requets.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/phase.dart';
import 'package:app/models/units.dart';
import 'package:app/models/user.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletePhaseDialog extends StatelessWidget {
  final QPUser user;
  final String previewId;
  final Function onComplete;
  final Brightness deviceBrightness;
  final Phase phase;

  CompletePhaseDialog({
    Key key,
    @required this.user,
    @required this.phase,
    @required this.previewId,
    @required this.onComplete,
    @required this.deviceBrightness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
      contentPadding: EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
      title: SizedBox(
        width: MediaQuery.of(context).size.width - 96.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              "Finalizar capítulo",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              ),
            )
          ],
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Esta a punto de finalizar una fase del proyecto, está acción no puede ser revertida.\n\n¿Aún desea continuar?",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 16,
              color: deviceBrightness == Brightness.dark
                  ? QPColors.gainsboro
                  : QPColors.san_juan,
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          QuickPlannerButton(
              text: 'aceptar',
              onPressed: () {
                finishPhase(user, phase.reference, previewId);
                Navigator.of(context, rootNavigator: true).pop();
              }),
        ],
      ),
    );
  }
}
