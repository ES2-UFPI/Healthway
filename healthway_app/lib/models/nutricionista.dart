class Nutricionista {
  final String id;
  final String cpf;
  final String crn;
  final String nome;
  final String especialidade;
  final String email;
  final String fotoPerfil;

  Nutricionista({
    required this.id,
    required this.cpf,
    required this.crn,
    required this.nome,
    required this.especialidade,
    required this.email,
    required this.fotoPerfil,
  });

  factory Nutricionista.fromJson(Map<String, dynamic> json) {
    return Nutricionista(
      id: json['id'] ?? '',
      cpf: json['cpf'] ?? '',
      crn: json['crn'] ?? '',
      nome: json['nome'] ?? '',
      especialidade: json['especialidade'] ?? '',
      email: json['email'] ?? '',
      fotoPerfil: json['foto_perfil'] ?? '',
    );
  }
}
