import 'package:app/backend/requets.dart';
import 'package:app/models/stock_item.dart';
import 'package:app/models/units.dart';
import 'package:app/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddStockDialog extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CollectionReference stockReference;
  final Function onStockAdded;

  AddStockDialog(
      {Key key, @required this.stockReference, @required this.onStockAdded})
      : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<AddStockDialog> {
  QPUnit _selectedUnit;
  TextEditingController _nameController, _neededController;

  @override
  void initState() {
    super.initState();
    _selectedUnit = QPUnit(1);
    _nameController = TextEditingController();
    _neededController = TextEditingController();
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
              "Detalles del producto",
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
              controller: _nameController,
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
              "Necesario:",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    keyboardType: TextInputType.number,
                    controller: _neededController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Ingresa la cantidad';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 32.0,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: _selectedUnit.value,
                      items: [
                        DropdownMenuItem(
                          child: Text("UND"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("kg"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("lb"),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text("mt"),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text("cm"),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text("l"),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          child: Text("ml"),
                          value: 7,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedUnit = QPUnit(value);
                        });
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            QuickPlannerButton(
                text: 'aceptar',
                onPressed: () {
                  if (widget._formKey.currentState.validate()) {
                    StockItem stockItem = StockItem(_nameController.text,
                        _selectedUnit.name, int.parse(_neededController.text));
                    addStockItem(widget.stockReference, stockItem)
                        .then((value) => widget.onStockAdded.call(value));
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
    _nameController.dispose();
    _neededController.dispose();
    super.dispose();
  }
}
