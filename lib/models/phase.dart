import 'package:app/constants/enums.dart';
import 'package:app/models/stock_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Phase {
  final String title, unit;
  final int eta;
  CollectionReference stock;
  QPState state;

  Phase(this.title, this.unit, this.eta, this.state, {this.stock});

  factory Phase.fromJson(Map<String, dynamic> json) {
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'unit': this.unit,
      'eta': this.eta,
      'state': _stateToString(this.state),
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
