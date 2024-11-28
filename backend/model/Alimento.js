class Alimento {
    constructor(nome, peso, porcao, proteinas, carboidratos, calorias, gordura){
        this.nome = nome;
        this.peso = peso;
        this.porcao = porcao;
        this.proteinas = proteinas;
        this.carboidratos = carboidratos;
        this.calorias = calorias;
        this.gordura = gordura;
    }
    toFirestore(){
        return {
            nome: this.nome,
            peso: this.peso,
            porcao: this.porcao,
            proteinas: this.proteinas,
            carboidratos: this.carboidratos,
            calorias: this.calorias,
            gordura: this.gordura
        };
    }
}

module.exports = Alimento;