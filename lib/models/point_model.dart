class Point {

  final dynamic id;
  final dynamic name;
  final dynamic lat;
  final dynamic long;
  final dynamic center;
  final dynamic tipoDeReciclado;
  final dynamic intermediarys;


  Point({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.center,
    required this.tipoDeReciclado,
    required this.intermediarys,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      id: json['id'],
      name: json['nombre'],
      lat: json['lat'],
      long: json['long'],
      center: json['centro'],
      tipoDeReciclado: json['getTiporeciclado'],
      intermediarys: json['intermediarys'],
    );
  }
}


