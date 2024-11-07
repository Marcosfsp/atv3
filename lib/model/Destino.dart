class Destino {
  final int id;
  final String nome;
  final double distancia; // km

  Destino({required this.id, required this.nome, required this.distancia});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'distancia': distancia,
    };
  }

static Destino fromMap(Map<String, dynamic> map) {
    return Destino(
      id: map['id'],
      nome: map['nome'],
      distancia: map['distancia'],
    );
  }

}