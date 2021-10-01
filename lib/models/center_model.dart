import 'package:ecoinclution_proyect/models/place_model.dart';

class CenterModel extends Place{
  final dynamic url;
  final dynamic telefono;
  final dynamic initTime;
  final dynamic stopTime;
  final dynamic verified;


  CenterModel({
    required this.url,
    required id,
    required name,
    required lat,
    required lng,
    required recycleType,
    required this.telefono,
    required this.initTime,
    required this.stopTime,
    required this.verified

  }): super(id: id, name: name, lat: lat, lng: lng,recycleType: recycleType);

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    return CenterModel(
      url: json['url'],
      id: json['id'],
      name: json['nombre'],
      lat: json['lat'],
      lng: json['long'],
      recycleType: json['tipo_de_reciclado'],
      telefono: json['telefono'],
      initTime: json['horario_inicio'],
      stopTime: json['horario_final'],
      verified: json['verificado'],
    );
  }

  Map <String, dynamic> toDatabaseJson() => {
    "url": this.url,
    "id": this.id,
    "nombre": this.name,
    "lat": this.lat,
    "long": this.lng,
    "tipo_de_reciclado": this.recycleType,
    "telefono": this.telefono,
    "horarioInicio": this.initTime,
    "horarioFinal": this.stopTime,
    "verificado": this.verified,
  };
}


