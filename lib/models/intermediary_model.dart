
import 'package:ecoinclution_proyect/models/models.dart';

class Intermediary {
  final dynamic url;
  final dynamic id;
  final dynamic name;
  final dynamic phone;
  CenterModel center;
  List<Place> places;
  final dynamic days;

  Intermediary({
    required this.url,
    required this.id,
    required this.name,
    required this.phone,
    required this.center,
    required this.places,
    required this.days,
  });

  factory Intermediary.fromJson(Map<String, dynamic> json,{required List<Place> places, required List<CenterModel> centers}) {
    late CenterModel center;

    centers.forEach((ele){
      if (json["centro"] == ele.id) {
        center = ele;
      }
    });
    List<Place> placesFrom = [];
    List<dynamic> placesJson = json["lugares"];
    places.forEach((ele){

      if (placesJson.contains(ele.id)) {
        placesFrom.add(ele);
      }
    });
    return Intermediary(
      url: json['url'],
      id: json['id'],
      name: json['nombre'],
      phone: json['telefono'],
      center: center,
      places: placesFrom,
      days: json['dias_disponibles'],
    );
  }
}


