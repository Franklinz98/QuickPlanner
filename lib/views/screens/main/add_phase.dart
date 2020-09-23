import 'package:app/backend/requets.dart';
import 'package:app/components/no_items.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/enums.dart';
import 'package:app/models/phase.dart';
import 'package:app/models/stock_item.dart';
import 'package:app/models/units.dart';
import 'package:app/models/user.dart';
import 'package:app/widgets/list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPhase extends StatefulWidget {
  final Function onBackPressed;
  final QPUser user;
  final int id;
  final DocumentReference phaseReference, projectReference;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddPhase({
    Key key,
    @required this.user,
    @required this.id,
    @required this.projectReference,
    @required this.phaseReference,
    @required this.onBackPressed,
  }) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<AddPhase> with WidgetsBindingObserver {
  Brightness _brightnessValue;
  QPTimeUnit _selectedUnit;
  Stream<QuerySnapshot> _stockStream;
  TextEditingController _nameController, _etaController;

  @override
  void initState() {
    super.initState();
    _selectedUnit = QPTimeUnit(1);
    _nameController = TextEditingController();
    _etaController = TextEditingController();
    WidgetsBinding.instance.addObserver(this);
    _stockStream = getStockStream(widget.phaseReference.collection('stock'));
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
                "Agregar capítulo",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    cancelPhaseCreation(widget.phaseReference).then((value) {
                      if (value) {
                        widget.onBackPressed.call();
                      }
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    if (widget._formKey.currentState.validate()) {
                      Phase phase = Phase(
                          _nameController.text,
                          _selectedUnit.name,
                          int.parse(_etaController.text),
                          QPState.onTrack);

                      confirmPhaseCreation(widget.projectReference,
                              widget.id+1, widget.phaseReference, phase)
                          .then((value) {
                        if (value) {
                          widget.onBackPressed.call();
                        }
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: widget._formKey,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Titulo:",
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
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ingresa el nombre del producto';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Estimado:",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                              ),
                              controller: _etaController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Ingresa la cantidad necesaria';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                                value: _selectedUnit.value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("días"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("semanas"),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("meses"),
                                    value: 3,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("años"),
                                    value: 4,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedUnit = QPTimeUnit(value);
                                  });
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Inventario:",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
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
      stream: _stockStream,
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
              StockItem stock = StockItem.fromJson(documentSnapshot.data());
              stock.reference = documentSnapshot.reference;
              return QPListTile(
                  title: stock.title,
                  subtitle: 'Necesario: ${stock.needed} ${stock.unit}',
                  deviceBrightness: _brightnessValue,
                  onLongPress: () {
                    removeStockItem(stock);
                  });
            },
            itemCount: documents.length,
          );
        }
        return NoItemsImage(deviceBrightness: _brightnessValue);
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _etaController.dispose();
    super.dispose();
  }
}
