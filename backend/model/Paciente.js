class Paciente {
  constructor({
    id = null,
    alergias = [],
    altura = 0,
    cpf = "",
    data_nascimento = new Date(),
    email = "",
    foto_perfil = null,
    nome = "",
    peso = 0,
    sexo = "",
    circunferencia_abdominal = 0,
    gordura_corporal = 0,
    massa_muscular = 0,
    preferencias = {},
    senha = "",
  }) {
    this.id = id; // String (opcional)
    this.alergias = alergias; // Lista de Strings
    this.altura = altura; // Número (double)
    this.cpf = cpf; // String
    this.data_nascimento = new Date(data_nascimento); // Date
    this.email = email; // String
    this.foto_perfil = foto_perfil; // String (opcional)
    this.nome = nome; // String
    this.peso = peso; // Número (double)
    this.sexo = sexo; // String
    this.circunferencia_abdominal = circunferencia_abdominal; // Número (double)
    this.gordura_corporal = gordura_corporal; // Número (double)
    this.massa_muscular = massa_muscular; // Número (double)
    this.preferencias = preferencias; // Objeto (Map)
    this.senha = senha; // String
  }

  // Método estático para criar um objeto Paciente a partir de JSON
  static fromJson(json) {
    return new Paciente({
      id: json.id || null,
      alergias: Array.isArray(json.alergias) ? json.alergias : [],
      altura: parseFloat(json.altura || 0),
      cpf: json.cpf || "",
      data_nascimento: json.data_nascimento || new Date(),
      email: json.email || "",
      foto_perfil: json.foto_perfil || null,
      nome: json.nome || "",
      peso: parseFloat(json.peso || 0),
      sexo: json.sexo || "",
      circunferencia_abdominal: parseFloat(json.circunferencia_abdominal || 0),
      gordura_corporal: parseFloat(json.gordura_corporal || 0),
      massa_muscular: parseFloat(json.massa_muscular || 0),
      preferencias: json.preferencias || {},
      senha: json.senha || "",
    });
  }

  // Método para converter um objeto Paciente para JSON
  toJson() {
    return {
      id: this.id,
      alergias: this.alergias,
      altura: this.altura,
      cpf: this.cpf,
      data_nascimento: this.data_nascimento.toISOString(),
      email: this.email,
      foto_perfil: this.foto_perfil,
      nome: this.nome,
      peso: this.peso,
      sexo: this.sexo,
      circunferencia_abdominal: this.circunferencia_abdominal,
      gordura_corporal: this.gordura_corporal,
      massa_muscular: this.massa_muscular,
      preferencias: this.preferencias,
      senha: this.senha,
    };
  }
}

module.exports = Paciente; // Exporta a classe para uso em outros módulos
