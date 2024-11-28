class PlanoAlimentar {
    constructor(consulta, dt_inicio, dt_fim, refeicoes, paciente) {
        this.consulta = consulta;
        this.dt_inicio = dt_inicio;
        this.dt_fim = dt_fim;
        this.refeicoes = refeicoes;
        this.paciente = paciente;
    }

    toFirestore() {
        return {
            consulta: this.consulta,
            dt_inicio: this.dt_inicio,
            dt_fim: this.dt_fim,
            refeicoes: this.refeicoes,
            paciente: this.paciente
        };
    }
  }

  module.exports = PlanoAlimentar;