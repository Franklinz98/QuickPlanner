import 'package:app/backend/requets.dart';
import 'package:app/components/no_items.dart';
import 'package:app/components/no_projects.dart';
import 'package:app/components/model_description.dart';
import 'package:app/components/update_stock_dialog.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/phase.dart';
import 'package:app/models/project.dart';
import 'package:app/models/project_preview.dart';
import 'package:app/models/stock_item.dart';
import 'package:app/models/user.dart';
import 'package:app/provider/provider.dart';
import 'package:app/widgets/list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhaseDetails extends StatefulWidget {
  final Function onBackPressed;
  final QPUser user;

  const PhaseDetails({
    Key key,
    @required this.user,
    @required this.onBackPressed,
  }) : super(key: key);

  @override
  _PhasetState createState() => _PhasetState();
}

class _PhasetState extends State<PhaseDetails> with WidgetsBindingObserver {
  Brightness _brightnessValue;
  Stream<QuerySnapshot> _stockStream;
  Phase phase;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    phase = Provider.of<QuickPlannerModel>(context, listen: false).phase;
    _stockStream = getStockStream(phase.reference.collection('stock'));
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
                "Detalles del capítulo",
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
        ProjectDescription(
            model: phase,
            listTitle: 'Inventario:',
            deviceBrightness: _brightnessValue),
        Expanded(
          child: _getStreamBuilder(),
        ),
      ],
    );
  }

// Change to stock list
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
          bool phaseHasWarnigns = false;
          StockItem tempStock;
          documents.forEach((document) {
            tempStock = StockItem.fromJson(document.data());
            phaseHasWarnigns |= tempStock.needed > 0;
          });
          updateState(
              phaseHasWarnigns,
              Provider.of<QuickPlannerModel>(context, listen: false)
                  .project
                  .reference,
              Provider.of<QuickPlannerModel>(context, listen: false)
                  .phase
                  .reference);
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemBuilder: (_, index) {
              QueryDocumentSnapshot documentSnapshot = documents[index];
              StockItem stock = StockItem.fromJson(documentSnapshot.data());
              stock.reference = documentSnapshot.reference;
              return QPListTile(
                title: stock.title,
                subtitle: 'Existencias: ${stock.stock} ${stock.unit}',
                deviceBrightness: _brightnessValue,
                onTap: !widget.user.admin
                    ? () {
                        showDialog(
                          context: context,
                          builder: (_) => UpdateStockDialog(
                            onUpdatedItem: (result) {
                              String message;
                              if (result) {
                                message = 'Agregado.';
                              } else {
                                message =
                                    'No se pudo agregar, vuelve a intentarlo.';
                              }
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(message)));
                            },
                            stockItem: stock,
                            deviceBrightness: _brightnessValue,
                          ),
                        );
                      }
                    : null,
              );
            },
            itemCount: documents.length,
          );
        }
        return NoItemsImage(deviceBrightness: _brightnessValue);
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
