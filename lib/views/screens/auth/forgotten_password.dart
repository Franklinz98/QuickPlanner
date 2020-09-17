import 'package:app/backend/authentication.dart';
import 'package:app/constants/colors.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgotten extends StatefulWidget {
  final Brightness deviceBrightness;
  final Function onScreenSwitch;

  const Forgotten({
    Key key,
    @required this.deviceBrightness,
    @required this.onScreenSwitch,
  }) : super(key: key);

  @override
  _ForgottenState createState() => _ForgottenState();
}

class _ForgottenState extends State<Forgotten> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  Brightness brightnessValue;
  TextEditingController _emailTextController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    brightnessValue = widget.deviceBrightness;
    _emailTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: brightnessValue == Brightness.light
                      ? Colors.white
                      : QPColors.nero,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Colors.black.withOpacity(0.16),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(4.00),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Recupera tu contraseña\nIngresa tu correo electrónico",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: brightnessValue == Brightness.light
                                ? QPColors.san_juan
                                : QPColors.gainsboro,
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                          controller: _emailTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresa tu correo electrónico';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        QuickPlannerButton(
                          text: 'recuperar contraseña',
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Verificando..."),
                                ),
                              );
                              recover(_emailTextController.text).then((value) {
                                if (value) {
                                  widget.onScreenSwitch.call();
                                } else {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Vuelve a intentarlo."),
                                    ),
                                  );
                                }
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GestureDetector(
            child: Text(
              "INICIAR SESIÓN",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xffe86450),
              ),
            ),
            onTap: widget.onScreenSwitch,
          ),
        ),
      ],
    );
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      brightnessValue = WidgetsBinding.instance.window.platformBrightness;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _emailTextController.dispose();
    super.dispose();
  }
}
