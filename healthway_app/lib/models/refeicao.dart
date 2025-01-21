class Refeicao {
  final String? id;
  String nome;
  String observacoes;
  Map<String, String> alimentos;

  Refeicao({
    this.id,
    required this.nome,
    required this.observacoes,
    required this.alimentos,
  });

  factory Refeicao.fromJson(Map<String, dynamic> json) {
    return Refeicao(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      observacoes: json['observacoes'] ?? '',
      alimentos: Map<String, String>.from(json['alimentos'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'observacoes': observacoes,
      'alimentos': alimentos,
    };
  }
}
