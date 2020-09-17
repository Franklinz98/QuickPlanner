import 'package:app/widgets/profile_letter.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  final profile;
  final termsAndCond;
  final privacyPolicy;
  final licences;
  final onLogOff;
  final QPUser user;

  const CustomDrawer(
      {Key key,
      @required this.user,
      @required this.profile,
      @required this.termsAndCond,
      @required this.privacyPolicy,
      @required this.licences,
      @required this.onLogOff})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: ProfileLetter(
                    letter: user.name.substring(0, 1),
                    style: GoogleFonts.roboto(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                    size: 90.0,
                  ),
                ),
              ),
              Text(
                user.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                user.email,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
              ),
              Text(
                user.phone,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
              ),
              ListTile(
                  title: Text(
                    "Editar Perfil",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  dense: true,
                  onTap: this.profile),
              Spacer(),
              ListTile(
                  title: Text(
                    "Términos y Condiciones",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  dense: true,
                  onTap: this.termsAndCond),
              ListTile(
                  title: Text(
                    "Política de Privacidad",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  dense: true,
                  onTap: this.privacyPolicy),
              ListTile(
                  title: Text(
                    "Licencias y Bibliotecas",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  dense: true,
                  onTap: this.licences),
              Spacer(),
              ListTile(
                  title: Text(
                    "Cerrar Sesión",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  dense: true,
                  onTap: this.onLogOff),
            ],
          ),
        ),
      ),
    );
  }
}
