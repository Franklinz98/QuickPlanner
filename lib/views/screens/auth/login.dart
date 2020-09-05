import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  final Brightness deviceBrightness;
  final Function onScreenSwitch;
  final Function forgottenPasswordTap;

  const Login({
    Key key,
    @required this.deviceBrightness,
    @required this.onScreenSwitch,
    @required this.forgottenPasswordTap,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  Brightness brightnessValue;
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    brightnessValue = widget.deviceBrightness;
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
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
                      : QuickPlannerColors.nero,
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
                          "¡Bienvenido!\nConfirma tus credenciales",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: brightnessValue == Brightness.light
                                ? QuickPlannerColors.san_juan
                                : QuickPlannerColors.gainsboro,
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Text(
                          "Correo Electrónico",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
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
                          height: 12.0,
                        ),
                        Text(
                          "Contraseña",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                          ),
                          controller: _passwordTextController,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresa tu contraseña';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Olvidé mi contraseña",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xffe86450),
                              ),
                            ),
                          ),
                          onTap: widget.forgottenPasswordTap,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          height: 42.00,
                          decoration: BoxDecoration(
                            color: Color(0xffe86450),
                            borderRadius: BorderRadius.circular(4.00),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {}
                            },
                            child: Text(
                              "INICIAR SESIÓN",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
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
              "NO TENGO CUENTA",
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
    _passwordTextController.dispose();
    super.dispose();
  }
}
