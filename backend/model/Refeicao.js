class Refeicao {
    constructor({id = '', nome, alimentos, observacoes}) {
        this.id = id;
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