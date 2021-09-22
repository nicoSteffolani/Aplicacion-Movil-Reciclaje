class AmountRecycle {
  final dynamic id;
  dynamic deposit;
  final dynamic amount;
  final dynamic weight;
  final dynamic recycleType;

  AmountRecycle({
    this.id,
    this.deposit,
    required this.amount,
    required this.weight,
    required this.recycleType,
  });

  factory AmountRecycle.fromJson(Map<String, dynamic> json) {
    return AmountRecycle(
      id: json['id'],
      deposit: json['deposito'],
      amount: json['cantidad'],
      weight: json['peso'],
      recycleType: json['tipo_de_reciclado'],
    );
  }

  Map <String, dynamic> toDatabaseJson() => {
    "deposito": this.deposit,
    "cantidad": this.amount,
    "peso": this.weight,
    "tipo_de_reciclado": this.recycleType,
  };
}

