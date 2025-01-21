import 'package:cloud_firestore/cloud_firestore.dart';


class PlanoAlimentar {
  final String id;
  final String consulta;
  final String idPaciente;
  final List<String> refeicoes;

  // Apenas para controle interno do banco de dados
  final Timestamp dtInicio;
  final Timestamp dtFim;

  PlanoAlimentar({
    required this.id,
    required this.consulta,
    required this.idPaciente,
    required this.refeicoes,
    required this.dtInicio,
    required this.dtFim,
  });

  factory PlanoAlimentar.fromMap(Map<String, dynamic> map) {
    return PlanoAlimentar(
      id: map['id'] ?? '',
      dtInicio: map['dt_inicio'] ?? Timestamp(0, 0),  // Usando Timestamp para salvar os dados
      dtFim: map['dt_fim'] ?? Timestamp(0, 0),
      consulta: map['consulta'] ?? '',
      idPaciente: map['id_paciente'] ?? '',
      refeicoes: List<String>.from(map['refeicoes'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dt_inicio': dtInicio,
      'dt_fim': dtFim,
      'consulta': consulta,
      'id_paciente': idPaciente,
      'refeicoes': refeicoes,
    };
  }

  // Função auxiliar para exibir a data de forma amigável, caso necessário
  String formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }
}
