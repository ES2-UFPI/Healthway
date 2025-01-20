class Paciente {
    constructor(alergias, altura, cpf, data_nascimento, email, foto_perfil = '', nome, peso, sexo,
        circunferencia_abdominal, gordura_corporal, massa_muscular, preferencias, senha) {
        this.alergias = alergias;
        this.altura = altura;
        this.cpf = cpf;
        this.dt_nascimento = data_nascimento;
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
            dt_nascimento: this.dt_nascimento,
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

    fromJson(json) {
        this.alergias = json.alergias || '';
        this.altura = json.altura || 0;
        this.cpf = json.cpf || '';
        this.dt_nascimento = json.dt_nascimento || '';
        this.email = json.email || '';
        this.foto_perfil = json.foto_perfil || '';
        this.nome = json.nome || '';
        this.peso = parseFloat(json.peso) || 0;
        this.sexo = json.sexo || '';
        this.circunferencia_abdominal = parseFloat(json.circunferencia_abdominal) || 0;
        this.gordura_corporal = parseFloat(json.gordura_corporal) || 0;
        this.massa_muscular = parseFloat(json.massa_muscular) || 0;
        this.preferencias = json.preferencias || '';
        this.senha = json.senha || '';
    }
  }

module.exports = Paciente; // Exporta a classe para uso em outros módulos
