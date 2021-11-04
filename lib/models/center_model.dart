import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/place_model.dart';
import 'package:flutter/material.dart';

class CenterModel extends Place{
  final dynamic url;
  final dynamic telephone;
  final TimeOfDay initTime;
  final TimeOfDay stopTime;
  final dynamic verified;


  CenterModel({
    required this.url,
    required id,
    required name,
    required lat,
    required lng,
    required recyclingTypes,
    required this.telephone,
    required this.initTime,
    required this.stopTime,
    required this.verified

  }): super(id: id, name: name, lat: lat, lng: lng,recyclingTypes: recyclingTypes);

  factory CenterModel.fromJson(Map<String, dynamic> json, {required List<RecyclingType> recyclingTypes}) {
    List<RecyclingType> recyclingTypesFrom = [];
    List<dynamic> recyclingTypesJson = json["tipo_de_reciclado"];
    recyclingTypes.forEach((ele){
      if (recyclingTypesJson.contains(ele.id)) {
        recyclingTypesFrom.add(ele);
      }
    });
    return CenterModel(
      url: json['url'],
      id: json['id'],
      name: json['nombre'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['long']),
      recyclingTypes: recyclingTypesFrom,
      telephone: json['telefono'],
      initTime: TimeOfDay.fromDateTime(DateTime.parse("2021-01-01 ${json['horario_apertura']}")),
      stopTime: TimeOfDay.fromDateTime(DateTime.parse("2021-01-01 ${json['horario_cierre']}")),
      verified: json['verificado'],
    );
  }

  Map <String, dynamic> toDatabaseJson() {
    List<int> list = [];
    recyclingTypes.forEach((element) {
      list.add(element.id);
    });
    return {
      "url": this.url,
      "id": this.id,
      "nombre": this.name,
      "lat": this.lat,
      "long": this.lng,
      "tipo_de_reciclado": list,
      "telefono": this.telephone,
      "horarioInicio": this.initTime,
      "horarioFinal": this.stopTime,
      "verificado": this.verified,
    };
  }
}


