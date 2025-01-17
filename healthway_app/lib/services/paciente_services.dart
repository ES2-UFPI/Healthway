import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:healthway_app/models/paciente.dart';

class PacienteService {
  static const String apiUrl = 'http://localhost:3000/api/pacientes';

  Future<List<Paciente>> fetchPacientes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      try {
        List<dynamic>? data = json.decode(response.body);

        if (data != null) {
          return data.map((json) => Paciente.fromJson(json)).toList();
        } else {
          throw Exception('Dados não encontrados ou formato inválido');
        }
      } catch (e) {
        throw Exception('Erro ao parsear o JSON: $e');
      }
    } else {
      throw Exception('Falha ao carregar pacientes');
    }
  }

  Future<void> cadastrarPaciente(Paciente paciente) async {
    var uri = Uri.parse(apiUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields['nome'] = paciente.nome;
    request.fields['email'] = paciente.email;
    request.fields['cpf'] = paciente.cpf;
    request.fields['dataNascimento'] = paciente.dataNascimento;
    request.fields['sexo'] = paciente.sexo;
    request.fields['altura'] = paciente.altura.toString();
    request.fields['peso'] = paciente.peso.toString();
    request.fields['circunferenciaAbdominal'] =
        paciente.circunferenciaAbdominal.toString();
    request.fields['gorduraCorporal'] = paciente.gorduraCorporal.toString();
    request.fields['massaMuscular'] = paciente.massaMuscular.toString();
    request.fields['alergias'] = paciente.alergias;
    request.fields['preferencias'] = paciente.preferencias;
    request.fields['senha'] = paciente.senha;

    var response = await request.send();
    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar paciente');
    }
  }
}
