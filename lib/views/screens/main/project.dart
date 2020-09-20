import 'package:app/backend/requets.dart';
import 'package:app/components/no_items.dart';
import 'package:app/components/no_projects.dart';
import 'package:app/components/project_description.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/phase.dart';
import 'package:app/models/project.dart';
import 'package:app/models/project_preview.dart';
import 'package:app/models/user.dart';
import 'package:app/widgets/list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectDetails extends StatefulWidget {
  final Function onBackPressed;
  final QPUser user;
  final DocumentReference projectReference;

  const ProjectDetails({
    Key key,
    @required this.user,
    @required this.onBackPressed,
    @required this.projectReference,
  }) : super(key: key);

  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<ProjectDetails> with WidgetsBindingObserver {
  Brightness _brightnessValue;
  Stream<QuerySnapshot> _phasesStream;
  Future<Project> _projectFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _projectFuture = getProjectData(widget.projectReference);
    _phasesStream = getPhasesStream(widget.projectReference);
  }

  @override
  Widget build(BuildContext context) {
    _brightnessValue ??= MediaQuery.of(context).platformBrightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "Detalles del proyecto",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => widget.onBackPressed.call(),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
        Expanded(
          child: _getFutureBuilder(),
        ),
      ],
    );
  }

  StreamBuilder _getStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: _phasesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Ocurrió un error.')));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(QPColors.burnt_sienna),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          List<QueryDocumentSnapshot> documents = snapshot.data.docs;
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemBuilder: (_, index) {
              QueryDocumentSnapshot documentSnapshot = documents[index];
              Phase phase = Phase.fromJson(documentSnapshot.data());
              phase.stock = documentSnapshot.reference.collection('stock');
              return QPListTile(
                title: phase.title,
                subtitle: 'Estimado: ${phase.eta} ${phase.unit}',
                state: phase.state,
                deviceBrightness: _brightnessValue,
                onTap: () {},
              );
            },
            itemCount: documents.length,
          );
        }
        return NoItemsImage(deviceBrightness: _brightnessValue);
      },
    );
  }

  FutureBuilder _getFutureBuilder() {
    return FutureBuilder<Project>(
      future: _projectFuture,
      builder: (BuildContext context, AsyncSnapshot<Project> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProjectDescription(
                    project: snapshot.data, listTitle: 'Capítulos:', deviceBrightness: _brightnessValue),
                Expanded(
                  child: _getStreamBuilder(),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content:
                    Text('Ocurrió un error. ${snapshot.error.toString()}')));
          }
          return NoProjectsImage(deviceBrightness: _brightnessValue);
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(QPColors.burnt_sienna),
          ),
        );
      },
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
