import 'package:app/constants/colors.dart';
import 'package:app/models/project.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectDescription extends StatelessWidget {
  final Project project;
  final Brightness deviceBrightness;
  final String listTitle;

  const ProjectDescription({
    Key key,
    @required this.project,
    @required this.listTitle,
    @required this.deviceBrightness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                "Titulo:",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  project.title,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 16,
                    color: deviceBrightness == Brightness.dark
                        ? QPColors.gainsboro
                        : QPColors.san_juan,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            "Descripción:",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            project.description,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: deviceBrightness == Brightness.dark
                  ? QPColors.gainsboro
                  : QPColors.san_juan,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Text(
            this.listTitle,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
