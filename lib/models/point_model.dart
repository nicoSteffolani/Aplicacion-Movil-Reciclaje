import 'package:ecoinclution_proyect/models/place_model.dart';

class Point extends Place{
  final dynamic url;
  final dynamic center;
  final dynamic tipoDeReciclado;
  final dynamic intermediarys;


  Point({
    required this.url,
    required id,
    required name,
    required lat,
    required lng,
    required recycleType,
    required this.center,
    required this.tipoDeReciclado,
    required this.intermediarys,
  }) : super(id: id, name: name, lat: lat, lng: lng,recycleType: recycleType);

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      url: json['url'],
      id: json['id'],
      name: json['nombre'],
      lat: json['lat'],
      lng: json['long'],
      recycleType: json['tipo_de_reciclado'],
      center: json['centro'],
      tipoDeReciclado: json['getTiporeciclado'],
      intermediarys: json['cant_intermediarios'],
    );
  }
}


