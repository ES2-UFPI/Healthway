class Paciente {
    constructor(alergias, altura, cpf, data_nascimento, email, foto_perfil, nome, peso, sexo,
        circunferencia_abdominal, gordura_corporal, massa_muscular, preferencias, senha) {
        this.alergias = alergias;
        this.altura = altura;
        this.cpf = cpf;
        this.data_nascimento = data_nascimento;
        this.email = email;
        this.foto_perfil = foto_perfil;
        this.nome = nome;
        this.peso = peso;
        this.sexo = sexo;
        this.circunferencia_abdominal = circunferencia_abdominal;
        this.gordura_corporal = gordura_corporal;
        this.massa_muscular = massa_muscular;
        this.preferencias = preferencias;
        this.senha = senha;

    }

    toFirestore() {
        return {
            alergias: this.alergias,
            altura: this.altura,
            cpf: this.cpf,
            data_nascimento: this.data_nascimento,
            email: this.email,
            foto_perfil: this.foto_perfil,
            nome: this.nome,
            peso: this.peso,
            sexo: this.sexo,
            circunferencia_abdominal: this.circunferencia_abdominal,
            gordura_corporal: this.gordura_corporal,
            massa_muscular: this.massa_muscular,
            preferencias: this.preferencias,
            senha: this.senha
        };
    }
  }

  module.exports = Paciente;
