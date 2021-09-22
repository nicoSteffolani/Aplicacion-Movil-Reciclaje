class RecycleType {
  final dynamic id;
  final dynamic name;


  RecycleType({
    required this.id,
    required this.name,

  });

  factory RecycleType.fromJson(Map<String, dynamic> json) {
    return RecycleType(
      id: json['id'],
      name: json['nombre'],
    );
  }
}