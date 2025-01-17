class Nutricionista {
  final String? id;
  final String cpf;
  final String crn;
  final String nome;
  final String especialidade;
  final String email;
  final String senha;
  final String? fotoPerfil;
  final String? fotoDocumento;

  Nutricionista({
    this.id,
    required this.cpf,
    required this.crn,
    required this.nome,
    required this.especialidade,
    required this.email,
    required this.senha,
    this.fotoPerfil,
    this.fotoDocumento,
  });

  factory Nutricionista.fromJson(Map<String, dynamic> json) {
    return Nutricionista(
      id: json['id'],
      cpf: json['cpf'],
      crn: json['crn'],
      nome: json['nome'],
      especialidade: json['especialidade'],
      email: json['email'],
      senha: json['senha'],
      fotoPerfil: json['foto_perfil'],
      fotoDocumento: json['foto_documento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpf': cpf,
      'crn': crn,
      'nome': nome,
      'especialidade': especialidade,
      'email': email,
      'senha': senha,
      'foto_perfil': fotoPerfil,
      'foto_documento': fotoDocumento,
    };
  }
}
