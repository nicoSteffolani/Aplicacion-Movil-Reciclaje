class Deposit {
  final dynamic id;
  dynamic date;
  dynamic center;
  dynamic point;
  dynamic amounts;
  
  Deposit({
    this.id,
    this.date,
    this.center,
    this.point,
    this.amounts,
  });

  factory Deposit.fromJson(Map<String, dynamic> json) {
    return Deposit(
      id: json['id'],
      date: json['fecha'],
      center: json['centro'],
      point: json['punto_de_acopio'],
      amounts: json['getCantidades'],
      
    );
  }

  Map <String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "fecha": this.date,
    "centro": this.center,
    "punto_de_acopio": this.point,
    "getCantidades": this.amounts,
  };
  Map <String, dynamic> toJson() => {
    "fecha": this.date,
    "centro": this.center,
    "punto_de_acopio": this.point,
  };
}


