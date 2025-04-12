// lib/models/carne.dart
import 'dart:convert';

class Carne {
  String id;
  String nome;
  String freezerId;
  DateTime dataValidade;
  String funcionario;

  Carne({
    required this.id,
    required this.nome,
    required this.freezerId,
    required this.dataValidade,
    required this.funcionario,
  });

  bool get estaVencida => dataValidade.isBefore(DateTime.now());

  bool get estaProximaDoVencimento {
    final diff = dataValidade.difference(DateTime.now()).inDays;
    return diff <= 5;
  }

  String get corValidade {
    final diff = dataValidade.difference(DateTime.now()).inDays;
    if (diff <= 5) return 'preto';
    return 'verde';
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'nome': nome,
        'freezerId': freezerId,
        'dataValidade': dataValidade.toIso8601String(),
        'funcionario': funcionario,
      };

  factory Carne.fromMap(Map<String, dynamic> map) => Carne(
        id: map['id'],
        nome: map['nome'],
        freezerId: map['freezerId'] ?? '',
        dataValidade: DateTime.parse(map['dataValidade']),
        funcionario: map['funcionario'],
      );

  static String encode(List<Carne> carnes) =>
      json.encode(carnes.map((c) => c.toMap()).toList());

  static List<Carne> decode(String jsonStr) =>
      (json.decode(jsonStr) as List<dynamic>)
          .map<Carne>((item) => Carne.fromMap(item))
          .toList();
}
