import 'package:intl/intl.dart';

class PlanoAlimentar {
  final String? id;
  final String consulta;
  final DateTime dtInicio;
  final DateTime dtFim;
  final List<String> refeicoes;
  final String paciente;
  final String nutricionista;

  PlanoAlimentar({
    this.id,
    required this.consulta,
    required this.dtInicio,
    required this.dtFim,
    required this.refeicoes,
    required this.paciente,
    required this.nutricionista,
  });

  factory PlanoAlimentar.fromJson(Map<String, dynamic> json) {
    return PlanoAlimentar(
      id: json['id'] ?? '',
      consulta: json['consulta'] ?? '',
      dtInicio: DateFormat('dd/MM/yyyy').parse(json['dt_inicio'] ?? ''),
      dtFim: DateFormat('dd/MM/yyyy').parse(json['dt_fim'] ?? ''),
      refeicoes: List<String>.from(json['refeicoes'] ?? []),
      paciente: json['id_paciente'] ?? '',
      nutricionista: json['id_nutricionista'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'consulta': consulta,
      'dt_inicio': DateFormat('dd/MM/yyyy').format(dtInicio),
      'dt_fim': DateFormat('dd/MM/yyyy').format(dtFim),
      'refeicoes': refeicoes,
      'id_paciente': paciente,
      'id_nutricionista': nutricionista,
    };
  }
}
