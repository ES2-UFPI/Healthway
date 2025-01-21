import 'package:intl/intl.dart';

class PlanoAlimentar {
  final String? id;
  final DateTime dtInicio;
  final DateTime dtFim;
  final List<String> refeicoes;
  final String pacienteId;
  final String nutricionistaId;

  PlanoAlimentar({
    this.id,
    required this.dtInicio,
    required this.dtFim,
    required this.refeicoes,
    required this.pacienteId,
    required this.nutricionistaId,
  });

  factory PlanoAlimentar.fromJson(Map<String, dynamic> json) {
    return PlanoAlimentar(
      id: json['id'] ?? '',
      dtInicio: DateFormat('dd/MM/yyyy').parse(json['dt_inicio'] ?? ''),
      dtFim: DateFormat('dd/MM/yyyy').parse(json['dt_fim'] ?? ''),
      refeicoes: List<String>.from(json['refeicoes'] ?? []),
      pacienteId: json['id_paciente'] ?? '',
      nutricionistaId: json['id_nutricionista'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dt_inicio': DateFormat('dd/MM/yyyy').format(dtInicio),
      'dt_fim': DateFormat('dd/MM/yyyy').format(dtFim),
      'refeicoes': refeicoes,
      'id_paciente': pacienteId,
      'id_nutricionista': nutricionistaId,
    };
  }
}
