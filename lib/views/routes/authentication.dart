import 'package:app/backend/authentication.dart';
import 'package:app/constants/enums.dart';
import 'package:app/provider/provider.dart';
import 'package:app/views/routes/main.dart';
import 'package:app/views/screens/auth/forgotten_password.dart';
import 'package:app/views/screens/auth/login.dart';
import 'package:app/views/screens/auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Authentication> with WidgetsBindingObserver {
  Brightness _brightnessValue;
  Widget _content;
  AuthScreen _authScreen;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((value) {
      User firebaseUser = currentUser();
      if (firebaseUser != null) {
        getUserDetails(firebaseUser).then((user) async {
          user.admin = await isAdmin(user.uid);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  ChangeNotifierProvider<QuickPlannerModel>(
                create: (context) => QuickPlannerModel(),
                child: Main(
                  user: user,
                ),
              ),
            ),
          );
        });
      }
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    _brightnessValue ??= MediaQuery.of(context).platformBrightness;
    _content ??= Login(
      deviceBrightness: _brightnessValue,
      onScreenSwitch: () {
        setState(() {
          _authScreen = AuthScreen.signup;
          updateScreen();
        });
      },
      forgottenPasswordTap: () {
        setState(() {
          _authScreen = AuthScreen.forgotten;
          updateScreen();
        });
      },
    );
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

  updateScreen() {
    switch (_authScreen) {
      case AuthScreen.login:
        _content = Login(
          deviceBrightness: _brightnessValue,
          onScreenSwitch: () {
            setState(() {
              _authScreen = AuthScreen.signup;
              updateScreen();
            });
          },
          forgottenPasswordTap: () {
            setState(() {
              _authScreen = AuthScreen.forgotten;
              updateScreen();
            });
          },
        );
        break;
      case AuthScreen.signup:
        _content = SignUp(
            deviceBrightness: _brightnessValue,
            onScreenSwitch: () {
              setState(() {
                _authScreen = AuthScreen.login;
                updateScreen();
              });
            });
        break;
      case AuthScreen.forgotten:
        _content = Forgotten(
            deviceBrightness: _brightnessValue,
            onScreenSwitch: () {
              setState(() {
                _authScreen = AuthScreen.forgotten;
                updateScreen();
              });
            });
        break;
    }
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
