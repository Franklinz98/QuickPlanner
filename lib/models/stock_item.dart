import 'package:cloud_firestore/cloud_firestore.dart';

class StockItem {
  final String title, unit;
  DocumentReference reference;
  int needed;
  int stock, used;

  StockItem(this.title, this.unit, this.needed,
      {this.stock = 0, this.used = 0});

  updateStock(int newStock) {
    this.needed -= newStock;
    this.stock += newStock;
  }

  updateUsage(int usedStock) {
    this.stock -= usedStock;
    this.used += usedStock;
  }

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      json['title'],
      json['unit'],
      json['needed'],
      stock: json['stock'],
      used: json['used'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'unit': this.unit,
        'needed': this.needed,
        'stock': this.stock,
        'used': this.used,
      };
}
