import 'package:app/views/screens/auth/forgotten_password.dart';
import 'package:app/views/screens/auth/login.dart';
import 'package:app/views/screens/auth/signup.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Authentication> with WidgetsBindingObserver {
  Brightness _brightnessValue;
  Widget _content;
  Login _login;
  SignUp _signUp;
  Forgotten _forgotten;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    _brightnessValue ??= MediaQuery.of(context).platformBrightness;
    _login ??= Login(
      deviceBrightness: _brightnessValue,
      onScreenSwitch: () {
        setState(() {
          _content = _signUp;
        });
      },
      forgottenPasswordTap: () {
        setState(() {
          _content = _forgotten;
        });
      },
    );
    _signUp ??= SignUp(
        deviceBrightness: _brightnessValue,
        onScreenSwitch: () {
          setState(() {
            _content = _login;
          });
        });
    _forgotten ??= Forgotten(
        deviceBrightness: _brightnessValue,
        onScreenSwitch: () {
          setState(() {
            _content = _login;
          });
        });
    _content ??= _login;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/auth_background.png",
            height: _screenWidth / 1.5,
            width: _screenWidth,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 72.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/auth_logo.png",
              ),
            ),
          ),
          SafeArea(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _content,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangePlatformBrightness() {
    setState(() {
      _brightnessValue = WidgetsBinding.instance.window.platformBrightness;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
