class Alimento {
  final String id;
  final double calorias;
  final double carboidratos;
  final double proteinas;
  final String nome;
  final double gordura;
  final double peso;
  final String porcao;

  Alimento({
    required this.id,
    required this.calorias,
    required this.carboidratos,
    required this.proteinas,
    required this.nome,
    required this.gordura,
    required this.peso,
    required this.porcao,
  });

  factory Alimento.fromJson(Map<String, dynamic> json) {
    return Alimento(
      id: json['id'] ?? '',
      calorias: json['calorias']?.toDouble() ?? 0.0,
      carboidratos: json['carboidratos']?.toDouble() ?? 0.0,
      proteinas: json['proteinas']?.toDouble() ?? 0.0,
      nome: json['nome'] ?? '',
      gordura: json['gordura']?.toDouble() ?? 0.0,
      peso: json['peso']?.toDouble() ?? 0.0,
      porcao: json['porcao'] ?? '',
    );
  }
}
