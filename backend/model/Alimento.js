class Alimento {
    constructor(
        numero,
        descricao,
        umidade,
        energiaKcal,
        energiaKJ,
        proteina,
        lipideos,
        colesterol,
        carboidrato,
        fibraAlimentar,
        cinzas,
        calcio,
        magnesio,
        manganes,
        fosforo,
        ferro,
        sodio,
        potassio,
        cobre,
        zinco
    ) {
        this.numero = numero; // Número do Alimento
        this.descricao = descricao; // Descrição dos alimentos
        this.umidade = umidade; // Umidade (%)
        this.energiaKcal = energiaKcal; // Energia (Kcal)
        this.energiaKJ = energiaKJ; // Energia (KJ)
        this.proteina = proteina; // Proteína (g)
        this.lipideos = lipideos; // Lipídeos (g)
        this.colesterol = colesterol; // Colesterol (mg)
        this.carboidrato = carboidrato; // Carboidrato (g)
        this.fibraAlimentar = fibraAlimentar; // Fibra Alimentar (g)
        this.cinzas = cinzas; // Cinzas (g)
        this.calcio = calcio; // Cálcio (mg)
        this.magnesio = magnesio; // Magnésio (mg)
        this.manganes = manganes; // Manganês (mg)
        this.fosforo = fosforo; // Fósforo (mg)
        this.ferro = ferro; // Ferro (mg)
        this.sodio = sodio; // Sódio (mg)
        this.potassio = potassio; // Potássio (mg)
        this.cobre = cobre; // Cobre (mg)
        this.zinco = zinco; // Zinco (mg)
    }

    toFirestore() {
        return {
            numero: this.numero,
            descricao: this.descricao,
            umidade: this.umidade,
            energiaKcal: this.energiaKcal,
            energiaKJ: this.energiaKJ,
            proteina: this.proteina,
            lipideos: this.lipideos,
            colesterol: this.colesterol,
            carboidrato: this.carboidrato,
            fibraAlimentar: this.fibraAlimentar,
            cinzas: this.cinzas,
            calcio: this.calcio,
            magnesio: this.magnesio,
            manganes: this.manganes,
            fosforo: this.fosforo,
            ferro: this.ferro,
            sodio: this.sodio,
            potassio: this.potassio,
            cobre: this.cobre,
            zinco: this.zinco
        };
    }
}

module.exports = Alimento;
