import 'package:ecoinclution_proyect/models/models.dart';
import 'package:ecoinclution_proyect/models/place_model.dart';

class Point extends Place{
  final dynamic url;
  final dynamic center;
  final dynamic stringRecyclingType;
  final dynamic numIntermediaries;


  Point({
    required this.url,
    required id,
    required name,
    required lat,
    required lng,
    required recyclingType,
    required this.center,
    required this.stringRecyclingType,
    required this.numIntermediaries,
  }) : super(id: id, name: name, lat: lat, lng: lng,recyclingTypes: recyclingType);

  factory Point.fromJson(Map<String, dynamic> json, {required List<RecyclingType> recyclingTypes, required List<CenterModel> centers}) {
    late CenterModel center;
    centers.forEach((ele){
      if (json["centro"] == ele.id) {
        center = ele;
      }
    });
    List<RecyclingType> recyclingTypesFrom = [];
    List<dynamic> recyclingTypesJson = json["tipo_de_reciclado"];
    recyclingTypes.forEach((ele){
      if (recyclingTypesJson.contains(ele.id)) {
        recyclingTypesFrom.add(ele);
      }
    });
    return Point(
      url: json['url'],
      id: json['id'],
      name: json['nombre'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['long']),
      recyclingType: recyclingTypesFrom,
      center: center,
      stringRecyclingType: json['getTiporeciclado'],
      numIntermediaries: json['cant_intermediarios'],
    );
  }
}


