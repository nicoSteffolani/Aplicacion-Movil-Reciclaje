class CenterModel {
  final dynamic url;
  final dynamic id;
  final dynamic nombre;
  final dynamic lat;
  final dynamic long;
  final dynamic telefono;
  final dynamic horarioInicio;
  final dynamic horarioFinal;
  final dynamic verificado;


  CenterModel({
    required this.url,
    required this.id,
    required this.nombre,
    required this.lat,
    required this.long,
    required this.telefono,
    required this.horarioInicio,
    required this.horarioFinal,
    required this.verificado

  });

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    return CenterModel(
      url: json['url'],
      id: json['id'],
      nombre: json['nombre'],
      lat: json['lat'],
      long: json['long'],
      telefono: json['telefono'],
      horarioInicio: json['horario_inicio'],
      horarioFinal: json['horario_final'],
      verificado: json['verificado'],

    );
  }
}


