import 'package:ecoinclution_proyect/models/models.dart';

class Deposit {
  final dynamic id;
  Place place;
  dynamic amount;
  dynamic weight;
  RecyclingType recyclingType;
  dynamic date;
  dynamic dateOfDeposit;
  dynamic verified;

  
  Deposit({
    this.id,
    required this.place,
    this.amount,
    this.weight,
    required this.recyclingType,
    this.date,
    this.dateOfDeposit,
    this.verified,
  });

  factory Deposit.fromJson(Map<String, dynamic> json, {required List<RecyclingType> recyclingTypes, required List<Place> places}) {
    late RecyclingType recyclingType;
    late Place place;
    recyclingTypes.forEach((ele){
      if (json["tipo_de_reciclado"] == ele.id) {
        recyclingType = ele;
      }
    });
    places.forEach((ele){
      if (json["lugar"] == ele.id) {
        place = ele;
      }
    });
    return Deposit(
        id: json["id"],
        place: place,
        amount: json["cantidad"],
        weight: json["peso"],
        recyclingType: recyclingType,
        date: json["fecha"],
        dateOfDeposit: json["fecha_deposito"],
        verified: json["verificado"],
    );
  }

  Map <String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "lugar": this.place.id,
    "cantidad": (this.amount == "")?null:this.amount,
    "peso": (this.weight == "")?null:this.weight,
    "tipo_de_reciclado": this.recyclingType.id,
    "fecha": this.date,
  };
  Map <String, dynamic> toJson() => {
    "lugar": this.place.id,
    "cantidad": this.amount,
    "peso": this.weight,
    "tipo_de_reciclado": this.recyclingType.id,
    "fecha": this.date,
  };
}


