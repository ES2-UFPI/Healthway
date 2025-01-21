class Alimento {
    constructor(
        {descricao,
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
        zinco}
    ) {
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
            "Descrição dos alimentos": this.descricao,
            "Umidade (%)": this.umidade,
            "Energia (Kcal)": this.energiaKcal,
            "Energia (KJ)": this.energiaKJ,
            "Proteína (g)": this.proteina,
            "Lipídeos (g)": this.lipideos,
            "Colesterol (mg)": this.colesterol,
            "Carboidrato (g)": this.carboidrato,
            "Fibra Alimentar (g)": this.fibraAlimentar,
            "Cinzas (g)": this.cinzas,
            "Cálcio (mg)": this.calcio,
            "Magnésio (mg)": this.magnesio,
            "Manganês (mg)": this.manganes,
            "Fósforo (mg)": this.fosforo,
            "Ferro (mg)": this.ferro,
            "Sódio (mg)": this.sodio,
            "Potássio (mg)": this.potassio,
            "Cobre (mg)": this.cobre,
            "Zinco (mg)": this.zinco
        };
    }

    static fromJson(json) {
        return new Alimento({
            descricao: json["Descrição dos alimentos"],
            umidade: json["Umidade (%)"],
            energiaKcal: json["Energia (Kcal)"],
            energiaKJ: json["Energia (KJ)"],
            proteina: json["Proteína (g)"],
            lipideos: json["Lipídeos (g)"],
            colesterol: json["Colesterol (mg)"],
            carboidrato: json["Carboidrato (g)"],
            fibraAlimentar: json["Fibra Alimentar (g)"],
            cinzas: json["Cinzas (g)"],
            calcio: json["Cálcio (mg)"],
            magnesio: json["Magnésio (mg)"],
            manganes: json["Manganês (mg)"],
            fosforo: json["Fósforo (mg)"],
            ferro: json["Ferro (mg)"],
            sodio: json["Sódio (mg)"],
            potassio: json["Potássio (mg)"],
            cobre: json["Cobre (mg)"],
            zinco: json["Zinco (mg)"]
    });
    }
}

module.exports = Alimento;
