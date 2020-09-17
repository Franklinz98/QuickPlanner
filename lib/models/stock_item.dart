class StockItem {
  final String title, unit;
  final int needed;
  int stock, used;

  StockItem(this.title, this.unit, this.needed,
      {this.stock = 0, this.used = 0});

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
