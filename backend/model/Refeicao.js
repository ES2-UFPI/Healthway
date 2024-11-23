class Refeicao {
    constructor(nome, alimentos, observacoes) {
        this.nome = nome;
        this.alimentos = alimentos;
        this.observacoes = observacoes;
    }
    toFirestore() {
        return {
            nome: this.nome,
            alimentos: this.alimentos,
            observacoes: this.observacoes
        };
    }

}
module.exports = Refeicao;