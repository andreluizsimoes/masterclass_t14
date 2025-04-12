import 'dart:convert';

class Freezer {
  String id;
  String nome;

  Freezer({required this.id, required this.nome});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  factory Freezer.fromMap(Map<String, dynamic> map) {
    return Freezer(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Freezer.fromJson(String source) =>
      Freezer.fromMap(json.decode(source));

  static String encode(List<Freezer> freezers) =>
      json.encode(freezers.map((c) => c.toMap()).toList());

  static List<Freezer> decode(String jsonStr) =>
      (json.decode(jsonStr) as List<dynamic>)
          .map<Freezer>((item) => Freezer.fromMap(item))
          .toList();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Freezer && other.id == id && other.nome == nome;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode;
}
