class Carro {
  final int? id;
  final String modelo;
  final double autonomia; // km/L

  Carro({this.id, required this.modelo, required this.autonomia});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'modelo': modelo,
      'autonomia': autonomia,
    };
  }

static Carro fromMap(Map<String, dynamic> map) {
    return Carro(
      id: map['id'],
      modelo: map['modelo'],
      autonomia: map['autonomia'],
    );
  }

}