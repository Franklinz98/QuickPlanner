import 'package:app/backend/requets.dart';
import 'package:app/components/no_projects.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/project_preview.dart';
import 'package:app/models/user.dart';
import 'package:app/widgets/list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final Function openDrawer;
  final QPUser user;

  const Home({
    Key key,
    @required this.user,
    @required this.openDrawer,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  Brightness _brightnessValue;
  Future<List<ProjectPreview>> _futureProjects;
  Stream<QuerySnapshot> _streamProjects;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // _futureProjects = getProjectsFuture(widget.user);
    _streamProjects = getProjectsStream(widget.user);
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
                "Proyectos",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => widget.openDrawer.call(),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: _getStreamBuilder(),
        ),
      ],
    );
  }

  StreamBuilder _getStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: _streamProjects,
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
              ProjectPreview projectPreview =
                  ProjectPreview.fromJson(documents[index].data());
              return QPListTile(
                title: projectPreview.title,
                subtitle: widget.user.admin
                    ? projectPreview.owner
                    : 'Capítulo: ${projectPreview.phase}',
                state: projectPreview.state,
                subtitleInitial: widget.user.admin,
                deviceBrightness: _brightnessValue,
                onTap: () {},
              );
            },
            itemCount: documents.length,
          );
        }
        return NoProjectsImage(deviceBrightness: _brightnessValue);
      },
    );
  }

  FutureBuilder _getFutureBuilder() {
    return FutureBuilder<List<ProjectPreview>>(
      future: _futureProjects,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProjectPreview>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemBuilder: (_, index) {
                ProjectPreview projectPreview = snapshot.data[index];
                return QPListTile(
                  title: projectPreview.title,
                  subtitle: widget.user.admin
                      ? projectPreview.owner
                      : 'Capítulo: ${projectPreview.phase}',
                  state: projectPreview.state,
                  deviceBrightness: _brightnessValue,
                  onTap: () {},
                );
              },
              itemCount: snapshot.data.length,
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
