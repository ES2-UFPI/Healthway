class PlanoAlimentar {
    constructor(dt_inicio, dt_fim, refeicoes, paciente, nutricionista) {
        this.dt_inicio = dt_inicio;
        this.dt_fim = dt_fim;
        this.refeicoes = refeicoes;
        this.paciente = paciente;
        this.nutricionista = nutricionista;
    }

    toFirestore() {
        return {
            dt_inicio: this.dt_inicio,
            dt_fim: this.dt_fim,
            refeicoes: this.refeicoes,
            paciente: this.paciente,
            nutricionista: this.nutricionista
        };
    }
  }

  module.exports = PlanoAlimentar;