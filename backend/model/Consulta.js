class Consulta {
    constructor(nutricionista, paciente, data, observacoes, plano_alimentar) {
        this.nutricionista = nutricionista;
        this.paciente = paciente;
        this.data = data;
        this.observacoes = observacoes;
        this.plano_alimentar = plano_alimentar;

    }

    toFirestore() {
        return {
            nutricionista: this.nutricionista,
            paciente: this.paciente,
            data: this.data,
            observacoes: this.observacoes,
            plano_alimentar: this.plano_alimentar
        };
    }
  }

  module.exports = Consulta;
