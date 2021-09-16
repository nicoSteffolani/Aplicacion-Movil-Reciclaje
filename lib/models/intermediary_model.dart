
class Intermediary {
  final dynamic url;
  final dynamic id;
  final dynamic nombre;
  final dynamic telefono;
  final dynamic centro;
  final List<dynamic> puntos;
  final List<dynamic> dias;

  Intermediary({
    required this.url,
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.centro,
    required this.puntos,
    required this.dias,
  });

  factory Intermediary.fromJson(Map<String, dynamic> json) {
    return Intermediary(
      url: json['url'],
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      centro: json['centro'],
      puntos: json['puntos'],
      dias: json['dias_disponibles'],
    );
  }
}


