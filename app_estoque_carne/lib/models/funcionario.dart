class Funcionario {
  String id;
  String nome;

  Funcionario({required this.id, required this.nome});

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
  };

  factory Funcionario.fromJson(Map<String, dynamic> json) => Funcionario(
    id: json['id'],
    nome: json['nome'],
  );
}
