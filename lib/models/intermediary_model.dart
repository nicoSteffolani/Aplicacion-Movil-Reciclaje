
class Intermediary {
  final dynamic url;
  final dynamic id;
  final dynamic nombre;
  final dynamic telefono;
  final dynamic centro;
  final dynamic places;
  final dynamic dias;

  Intermediary({
    required this.url,
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.centro,
    required this.places,
    required this.dias,
  });

  factory Intermediary.fromJson(Map<String, dynamic> json) {
    return Intermediary(
      url: json['url'],
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      centro: json['centro'],
      places: json['lugares'],
      dias: json['dias_disponibles'],
    );
  }
}


