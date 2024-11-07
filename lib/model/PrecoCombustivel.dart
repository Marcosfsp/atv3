class PrecoCombustivel {
  final int id;
  final String tipo;
  final double preco; // preço por litro
  final DateTime data;

  PrecoCombustivel({required this.id, required this.tipo, required this.preco, required this.data});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'preco': preco,
      'data': data.toIso8601String(),
    };
  }

static PrecoCombustivel fromMap(Map<String, dynamic> map) {
    return PrecoCombustivel(
      id: map['id'],
      tipo: map['tipo'],
      preco: map['preco'],
      data: map['data'],
    );
  }

}