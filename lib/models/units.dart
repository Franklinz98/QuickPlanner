class QPUnit {
  String name;
  int value;

  QPUnit(this.value) {
    switch (value) {
      case 1:
        this.name = 'UND';
        break;
      case 2:
        this.name = 'kg';
        break;
      case 3:
        this.name = 'lb';
        break;
      case 4:
        this.name = 'mt';
        break;
      case 5:
        this.name = 'cm';
        break;
      case 6:
        this.name = 'l';
        break;
      case 7:
        this.name = 'ml';
        break;
    }
  }
}
