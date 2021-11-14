import 'package:ecoinclution_proyect/models/models.dart';

class Place {
  final dynamic id;
  final dynamic name;
  final double lat;
  final double lng;
  final String address;
  final List<RecyclingType> recyclingTypes;


  Place({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.address,
    required this.recyclingTypes,

  }) : assert(id > 0),
        assert(name.isNotEmpty);

  factory Place.fromJson(Map<String, dynamic> json, {required List<RecyclingType> recyclingTypes}) {
    List<RecyclingType> recyclingTypesFrom = [];
    List<dynamic> recyclingTypesJson = json["tipo_de_reciclado"];
    recyclingTypes.forEach((ele){
      if (recyclingTypesJson.contains(ele.id)) {
        recyclingTypesFrom.add(ele);
      }
    });
    return Place(
      id: json['id'],
      name: json['nombre'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['long']),
      address:  json['direccion'],
      recyclingTypes: recyclingTypesFrom,
    );
  }
}


