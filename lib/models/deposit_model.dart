class Deposit {
  final dynamic id;
  dynamic place;
  dynamic amount;
  dynamic weight;
  dynamic recycleType;
  dynamic date;
  dynamic dateOfDeposit;
  dynamic verified;

  
  Deposit({
    this.id,
    this.place,
    this.amount,
    this.weight,
    this.recycleType,
    this.date,
    this.dateOfDeposit,
    this.verified,
  });

  factory Deposit.fromJson(Map<String, dynamic> json) {
    return Deposit(
        id: json["id"],
        place: json["lugar"],
        amount: json["cantidad"],
        weight: json["peso"],
        recycleType: json["tipo_de_reciclado"],
        date: json["fecha"],
        dateOfDeposit: json["fecha_deposito"],
        verified: json["verificado"],
      
    );
  }

  Map <String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "lugar": this.place,
    "cantidad": (this.amount == "")?null:this.amount,
    "peso": (this.weight == "")?null:this.weight,
    "tipo_de_reciclado": this.recycleType,
    "fecha": this.date,
  };
  Map <String, dynamic> toJson() => {
    "lugar": this.place,
    "cantidad": this.amount,
    "peso": this.weight,
    "tipo_de_reciclado": this.recycleType,
    "fecha": this.date,
  };
}


