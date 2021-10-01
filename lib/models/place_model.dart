class Place {
  final dynamic id;
  final dynamic name;
  final dynamic lat;
  final dynamic lng;
  final dynamic recycleType;


  Place({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.recycleType,

  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['nombre'],
      lat: json['lat'],
      lng: json['long'],
      recycleType: json['tipo_de_reciclado'],
    );
  }
}


