class Alimento {
  final String id;
  final String categoria;
  final String descricao;
  final double umidade;
  final double energiaKcal;
  final double energiaKj;
  final double proteina;
  final double lipideos;
  final double colesterol;
  final double carboidrato;
  final double fibraAlimentar;
  final double cinzas;
  final double calcio;
  final double magnesio;
  final double manganes;
  final double fosforo;
  final double ferro;
  final double sodio;
  final double potassio;
  final double cobre;
  final double zinco;

  Alimento({
    required this.id,
    required this.categoria,
    required this.descricao,
    required this.umidade,
    required this.energiaKcal,
    required this.energiaKj,
    required this.proteina,
    required this.lipideos,
    required this.colesterol,
    required this.carboidrato,
    required this.fibraAlimentar,
    required this.cinzas,
    required this.calcio,
    required this.magnesio,
    required this.manganes,
    required this.fosforo,
    required this.ferro,
    required this.sodio,
    required this.potassio,
    required this.cobre,
    required this.zinco,
  });

  factory Alimento.fromJson(Map<String, dynamic> json) {
    return Alimento(
      id: json['id'] ?? '',
      categoria: json['Categoria'] ?? '',
      descricao: json['Descrição dos alimentos'] ?? '',
      umidade: double.tryParse(json['Umidade (%)']?.toString() ?? '0') ?? 0,
      energiaKcal: double.tryParse(json['Energia (Kcal)']?.toString() ?? '0') ?? 0,
      energiaKj: double.tryParse(json['Energia (KJ)']?.toString() ?? '0') ?? 0,
      proteina: double.tryParse(json['Proteína (g)']?.toString() ?? '0') ?? 0,
      lipideos: double.tryParse(json['Lipídeos (g)']?.toString() ?? '0') ?? 0,
      colesterol: double.tryParse(json['Colesterol (mg)']?.toString() ?? '0') ?? 0,
      carboidrato: double.tryParse(json['Carboidrato (g)']?.toString() ?? '0') ?? 0,
      fibraAlimentar: double.tryParse(json['Fibra Alimentar (g)']?.toString() ?? '0') ?? 0,
      cinzas: double.tryParse(json['Cinzas (g)']?.toString() ?? '0') ?? 0,
      calcio: double.tryParse(json['Cálcio (mg)']?.toString() ?? '0') ?? 0,
      magnesio: double.tryParse(json['Magnésio (mg)']?.toString() ?? '0') ?? 0,
      manganes: double.tryParse(json['Manganês (mg)']?.toString() ?? '0') ?? 0,
      fosforo: double.tryParse(json['Fósforo (mg)']?.toString() ?? '0') ?? 0,
      ferro: double.tryParse(json['Ferro (mg)']?.toString() ?? '0') ?? 0,
      sodio: double.tryParse(json['Sódio (mg)']?.toString() ?? '0') ?? 0,
      potassio: double.tryParse(json['Potássio (mg)']?.toString() ?? '0') ?? 0,
      cobre: double.tryParse(json['Cobre (mg)']?.toString() ?? '0') ?? 0,
      zinco: double.tryParse(json['Zinco (mg)']?.toString() ?? '0') ?? 0,
    );
  }
}
