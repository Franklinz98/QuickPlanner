import 'package:app/backend/authentication.dart';
import 'package:app/backend/requets.dart';
import 'package:app/components/project_dialog.dart';
import 'package:app/components/stock_dialog.dart';
import 'package:app/constants/enums.dart';
import 'package:app/models/phase.dart';
import 'package:app/models/project.dart';
import 'package:app/views/screens/main/add_phase.dart';
import 'package:app/views/screens/main/phase_details.dart';
import 'package:app/views/screens/main/project_details.dart';
import 'package:app/views/screens/policies/privacy_policy.dart';
import 'package:app/views/screens/policies/terms_cond.dart';
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
  bool _fabVisibility, _unfinishedPhases;
  Widget _content;
  Function _addProject, _addPhase, _addStock, _contactUs, _fabAction;
  DocumentReference _projectReference, _phaseReference;
  Phase _phaseObject;
  Project _projectObject;
  MainScreen _screen;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initFabActions();
    _screen = MainScreen.home;
    updateScreen();
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
          termsAndCond: () {
            _screen = MainScreen.tc;
            setState(() {
              updateScreen();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scaffoldKey.currentState.openEndDrawer();
              });
            });
          },
          privacyPolicy: () {
            _screen = MainScreen.pp;
            setState(() {
              updateScreen();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scaffoldKey.currentState.openEndDrawer();
              });
            });
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
    } else if (_screen == MainScreen.pp || _screen == MainScreen.tc) {
      _fabVisibility = false;
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

  resetPhasesState() {
    _unfinishedPhases = false;
  }

  updatePhasesState(bool value) {
    _unfinishedPhases |= value;
  }

  updateProjectObject(Project project) {
    _projectObject = project;
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
    _addPhase = () {
      print("object");
      if (!_unfinishedPhases) {
        createPhase(_projectObject.reference, _projectObject.phasesQuantity)
            .then((value) {
          _phaseReference = value;
          _screen = MainScreen.phaseAdd;
          setState(() {
            updateScreen();
          });
        });
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
                'Debes finalizar todos los capítulos para agregar uno nuevo.')));
      }
    };
    _addStock = () {
      showDialog(
        context: context,
        builder: (_) => AddStockDialog(
          stockReference: _screen == MainScreen.phase
              ? _phaseObject.reference.collection('stock')
              : _phaseReference.collection('stock'),
          onStockAdded: (result) {
            String message;
            if (result) {
              message = 'Agregado.';
            } else {
              message = 'No se pudo agregar, vuelve a intentarlo.';
            }
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
        ),
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

  updateScreen({DocumentReference documentReference, Phase phaseObject}) {
    _projectReference = documentReference ?? _projectReference;
    _phaseObject = phaseObject ?? _phaseObject;
    switch (_screen) {
      case MainScreen.home:
        _fabAction = _addProject;
        _content = Home(
            user: widget.user,
            openDrawer: () {
              _scaffoldKey.currentState.openDrawer();
            },
            onPreviewTap: (DocumentReference projectReference) {
              _screen = MainScreen.project;
              setState(() {
                updateScreen(documentReference: projectReference);
              });
            });
        break;
      case MainScreen.project:
        _fabAction = widget.user.admin ? _addPhase : _contactUs;
        _unfinishedPhases = false;
        _content = ProjectDetails(
          user: widget.user,
          projectReference: _projectReference,
          updateObject: (Project project) {
            updateProjectObject(project);
          },
          unfinishedReset: resetPhasesState,
          unfinishedUpdate: updatePhasesState,
          onBackPressed: () {
            _screen = MainScreen.home;
            setState(() {
              updateScreen();
            });
          },
          onPhasePressed: (Phase phase) {
            _screen = MainScreen.phase;
            setState(() {
              updateScreen(phaseObject: phase);
            });
          },
        );
        break;
      case MainScreen.phase:
        _fabAction = widget.user.admin ? _addStock : _contactUs;
        _content = PhaseDetails(
          user: widget.user,
          onBackPressed: () {
            _screen =
                _phaseObject != null ? MainScreen.project : MainScreen.home;
            setState(() {
              updateScreen();
            });
          },
          phase: _phaseObject,
        );
        break;
      case MainScreen.phaseAdd:
        _fabAction = _addStock;
        _content = AddPhase(
          user: widget.user,
          id: _projectObject.phasesQuantity,
          projectReference: _projectReference,
          phaseReference: _phaseReference,
          onBackPressed: () {
            _screen = _projectReference != null
                ? MainScreen.project
                : MainScreen.home;
            setState(() {
              updateScreen();
            });
          },
        );
        break;
      case MainScreen.pp:
        _content = PrivacyPolicy(
          onBackPressed: () {
            _screen = MainScreen.home;
            setState(() {
              updateScreen();
            });
          },
        );
        break;
      case MainScreen.tc:
        _content = TermsCond(
          onBackPressed: () {
            _screen = MainScreen.home;
            setState(() {
              updateScreen();
            });
          },
        );
        break;
    }
  }
}
