class PlanoAlimentar {
    constructor(dt_inicio, dt_fim, refeicoes, id_paciente, id_nutricionista) {
        this.dt_inicio = dt_inicio;
        this.dt_fim = dt_fim;
        this.refeicoes = refeicoes;
        this.id_paciente = id_paciente;
        this.id_nutricionista = id_nutricionista;
    }

    toFirestore() {
        return {
            dt_inicio: this.dt_inicio,
            dt_fim: this.dt_fim,
            refeicoes: this.refeicoes,
            id_paciente: this.id_paciente,
            id_nutricionista: this.id_nutricionista
        };
    }
  }

  module.exports = PlanoAlimentar;