import 'package:app/backend/requets.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/stock_item.dart';
import 'package:app/models/units.dart';
import 'package:app/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateStockDialog extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final StockItem stockItem;
  final Brightness deviceBrightness;
  final Function onUpdatedItem;

  UpdateStockDialog(
      {Key key,
      @required this.stockItem,
      @required this.deviceBrightness,
      @required this.onUpdatedItem})
      : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<UpdateStockDialog> {
  QPUnit _selectedUnit;
  TextEditingController _stockController, _usedController;

  @override
  void initState() {
    super.initState();
    _selectedUnit = QPUnit(1);
    _stockController = TextEditingController();
    _usedController = TextEditingController();
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
            Row(
              children: [
                Text(
                  "Nombre:",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    widget.stockItem.title,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      color: widget.deviceBrightness == Brightness.dark
                          ? QPColors.gainsboro
                          : QPColors.san_juan,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                Text(
                  "Necesario:",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    '${widget.stockItem.needed} ${widget.stockItem.unit}',
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      color: widget.deviceBrightness == Brightness.dark
                          ? QPColors.gainsboro
                          : QPColors.san_juan,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: [
                Text(
                  "Existencia:",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    '${widget.stockItem.stock} ${widget.stockItem.unit}',
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      color: widget.deviceBrightness == Brightness.dark
                          ? QPColors.gainsboro
                          : QPColors.san_juan,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Usado:",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    '${widget.stockItem.used} ${widget.stockItem.unit}',
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 16,
                      color: widget.deviceBrightness == Brightness.dark
                          ? QPColors.gainsboro
                          : QPColors.san_juan,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              "Agregar existencias:",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    keyboardType: TextInputType.number,
                    controller: _stockController,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  widget.stockItem.unit,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  flex: 2,
                  child: QuickPlannerButton(
                    text: 'actualizar',
                    onPressed: () {
                      widget.stockItem
                          .updateStock(int.parse(_stockController.text));
                      updateStock(widget.stockItem)
                          .then((value) => widget.onUpdatedItem.call(value));
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              "Actualizar consumo:",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    keyboardType: TextInputType.number,
                    controller: _usedController,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  widget.stockItem.unit,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  flex: 2,
                  child: QuickPlannerButton(
                    text: 'actualizar',
                    onPressed: () {
                      widget.stockItem
                          .updateUsage(int.parse(_usedController.text));
                      updateStock(widget.stockItem)
                          .then((value) => widget.onUpdatedItem.call(value));
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stockController.dispose();
    _usedController.dispose();
    super.dispose();
  }
}
