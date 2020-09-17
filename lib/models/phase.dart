import 'package:app/constants/enums.dart';
import 'package:app/models/stock_item.dart';

class Phase {
  final String title, unit;
  final int eta;
  List<StockItem> stock;
  QPState state;

  Phase(this.title, this.unit, this.eta, this.state, {this.stock}) {
    this.stock ??= List();
  }

  factory Phase.fromJson(Map<String, dynamic> json) {
    List<dynamic> stockJson = json['stock'];
    List<StockItem> stock = List();
    stockJson.forEach((element) {
      stock.add(StockItem.fromJson(element));
    });
    QPState state;
    switch (json['state']) {
      case 'finished':
        state = QPState.finished;
        break;
      case 'onTrack':
        state = QPState.onTrack;
        break;
      case 'withProblems':
        state = QPState.withProblems;
        break;
    }
    return Phase(
      json['title'],
      json['unit'],
      json['eta'],
      state,
      stock: stock,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> stockJson = List();
    this.stock.forEach((stockItem) {
      stockJson.add(stockItem.toJson());
    });
    return {
      'title': this.title,
      'unit': this.unit,
      'eta': this.eta,
      'state': _stateToString(this.state),
      'stock': stockJson,
    };
  }

  String _stateToString(QPState state) {
    switch (state) {
      case QPState.finished:
        return 'finished';
      case QPState.onTrack:
        return 'onTrack';
      case QPState.withProblems:
        return 'withProblems';
    }
    return '';
  }
}
