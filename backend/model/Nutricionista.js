class Nutricionista {
    constructor({ cpf, crn, email, especialidade, foto_perfil, foto_documento, nome }) {
      this.cpf = cpf;
      this.crn = crn;
      this.email = email;
      this.especialidade = especialidade;
      this.foto_perfil = foto_perfil;
      this.foto_documento = foto_documento;
      this.nome = nome;
    }

    toFirestore() {
      return {
        cpf: this.cpf,
        crn: this.crn,
        email: this.email,
        especialidade: this.especialidade,
        foto_perfil: this.foto_perfil,
        foto_documento: this.foto_documento,
        nome: this.nome,
      };
    }
  }

  module.exports = Nutricionista;
