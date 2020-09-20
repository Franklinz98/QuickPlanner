import 'package:app/backend/authentication.dart';
import 'package:app/components/project_dialog.dart';
import 'package:app/components/stock_dialog.dart';
import 'package:app/models/project_preview.dart';
import 'package:app/views/screens/main/project.dart';
import 'package:app/widgets/drawer.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/user.dart';
import 'package:app/views/routes/authentication.dart';
import 'package:app/views/screens/main/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Main extends StatefulWidget {
  final QPUser user;

  const Main({Key key, @required this.user}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Brightness _brightnessValue;
  bool _fabVisibility;
  Widget _content;
  Function _addProject, _addPhase, _addStock, _contactUs, _fabAction;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initFabActions();
    _content = Home(
      user: widget.user,
      openDrawer: () {
        _scaffoldKey.currentState.openDrawer();
      },
      onPreviewTap: (DocumentReference projectReference) {
        setState(() {
          _content = ProjectDetails(
              user: widget.user,
              onBackPressed: () {
                setState(() {
                  _content = Home(
                      user: widget.user,
                      openDrawer: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      onPreviewTap: () {});
                });
              },
              projectReference: projectReference);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _brightnessValue ??= MediaQuery.of(context).platformBrightness;
    print('state updated');
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: _content,
      ),
      drawer: CustomDrawer(
          user: widget.user,
          profile: () {
            // show Profile
          },
          termsAndCond: () {
            // show T&C
          },
          privacyPolicy: () {
            // show PP
          },
          licences: () {
            // show Libraries and Licenses
          },
          onLogOff: () {
            signOut().then((value) {
              if (value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Authentication(),
                  ),
                );
              }
            });
          }),
      floatingActionButton: fabUpdate(),
    );
  }

  Visibility fabUpdate() {
    IconData iconData;
    if (widget.user.admin) {
      _fabVisibility = _content.runtimeType != Home;
      iconData = Icons.add;
    } else {
      _fabVisibility = true;
      iconData =
          _content.runtimeType == Home ? Icons.add : Icons.chat_bubble_outline;
    }
    return Visibility(
      visible: _fabVisibility,
      child: FloatingActionButton(
        child: Icon(
          iconData,
          color: Colors.white,
        ),
        backgroundColor: QPColors.burnt_sienna,
        elevation: 0,
        onPressed: _fabAction,
      ),
    );
  }

  initFabActions() {
    _addProject = () {
      showDialog(
        context: context,
        builder: (_) => CreateProjectDialog(
          user: widget.user,
          onCreate: (result) {
            String message;
            if (result) {
              message = 'Proyecto creado.';
            } else {
              message = 'No se pudo crear el proyecto, vuelve a intentarlo.';
            }
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
        ),
      );
    };
    /* _addPhase = () {
      showDialog(
        context: context,
        builder: (_) => CreateProjectDialog(),
      );
    }; */
    _addStock = () {
      showDialog(
        context: context,
        builder: (_) => AddStockDialog(),
      );
    };
    _contactUs = () async {
      const url = "https://wa.me/573112148873";
      if (await canLaunch(url))
        launch(url);
      else
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("No podemos completar está acción"),
          ),
        );
    };
    _fabAction = _addProject;
  }
}
