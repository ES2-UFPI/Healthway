class Nutricionista {
  constructor({ cpf, crn, email, especialidade, nome, senha, pacientes }) {
    this.cpf = cpf;
    this.crn = crn;
    this.email = email;
    this.especialidade = especialidade;
    this.nome = nome;
    this.senha = senha;
    this.pacientes = pacientes;
  }

  toFirestore() {
    return {
    cpf: this.cpf,
    crn: this.crn,
    email: this.email,
    especialidade: this.especialidade,
    nome: this.nome,
    senha: this.senha,
    pacientes: this.pacientes,
    };
  }
  }

  module.exports = Nutricionista;
