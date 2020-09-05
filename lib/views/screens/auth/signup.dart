import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  final Brightness deviceBrightness;
  final Function onScreenSwitch;

  const SignUp({
    Key key,
    @required this.deviceBrightness,
    @required this.onScreenSwitch,
  }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  Brightness brightnessValue;
  TextEditingController _nameTextController;
  TextEditingController _phoneTextController;
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;
  TextEditingController _passwordConfTextController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    brightnessValue = widget.deviceBrightness;
    _nameTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _passwordConfTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 22.0,
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
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
                          "¿Primera vez aquí?\nRegístrate",
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
                          "Nombre",
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
                          controller: _nameTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresa tu nombre';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Teléfono",
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
                          keyboardType: TextInputType.phone,
                          controller: _phoneTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresa tu número de teléfono';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 12.0,
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
                          keyboardType: TextInputType.emailAddress,
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
                          obscureText: true,
                          controller: _passwordTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingresa tu contraseña';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Confirmar contraseña",
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
                          obscureText: true,
                          controller: _passwordConfTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Confirma tu contraseña';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24.0,
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
                              "REGISTRARSE",
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
          padding: const EdgeInsets.only(bottom: 24.0),
          child: GestureDetector(
            child: Text(
              "TENGO UNA CUENTA",
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
    _nameTextController.dispose();
    _phoneTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passwordConfTextController.dispose();
    super.dispose();
  }
}
