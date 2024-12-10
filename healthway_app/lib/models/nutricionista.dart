// lib/models/nutricionista.dart

class Nutricionista {
  final String nome;
  final String especialidade;

  Nutricionista({required this.nome, required this.especialidade});

  // Método de fábrica para criar uma instância a partir de um mapa
  factory Nutricionista.fromJson(Map<String, dynamic> json) {
    return Nutricionista(
      nome: json['nome'],
      especialidade: json['especialidade'],
    );
  }
}
