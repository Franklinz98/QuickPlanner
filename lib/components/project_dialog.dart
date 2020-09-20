import 'package:app/backend/requets.dart';
import 'package:app/models/project.dart';
import 'package:app/models/user.dart';
import 'package:app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateProjectDialog extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final QPUser user;
  final Function onCreate;

  CreateProjectDialog({Key key, @required this.user, @required this.onCreate})
      : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<CreateProjectDialog> {
  TextEditingController _titleController, _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
      contentPadding: EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
      title: SizedBox(
        width: MediaQuery.of(context).size.width - 96.0,
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
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              ),
            )
          ],
        ),
      ),
      content: Form(
        key: widget._formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nombre:",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
              controller: _titleController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Ingresa el nombre del proyecto';
                }
                return null;
              },
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              "Descripción:",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
              controller: _descriptionController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Ingresa la descripción';
                }
                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            QuickPlannerButton(
                text: 'aceptar',
                onPressed: () {
                  if (widget._formKey.currentState.validate()) {
                    Project project = Project(
                        _titleController.text, _descriptionController.text);
                    createProject(project, widget.user)
                        .then((value) => widget.onCreate.call(value));
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
