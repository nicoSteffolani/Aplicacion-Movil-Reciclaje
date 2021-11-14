class RecyclingType {
  final dynamic id;
  final dynamic name;


  RecyclingType({
    required this.id,
    required this.name,

  });

  factory RecyclingType.fromJson(Map<String, dynamic> json) {
    return RecyclingType(
      id: json['id'],
      name: json['nombre'],
    );
  }
}