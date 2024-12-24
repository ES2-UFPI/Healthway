import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/paciente.dart';
import 'dart:io';

class PacienteService {
  static const String apiUrl = 'http://localhost:3000/api/pacientes';

  Future<List<Paciente>> fetchPacientes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      try {
        List<dynamic> data = json.decode(response.body);

        if (data != null && data is List) {
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

  Future<void> cadastrarPaciente({
    required String nome,
    required String email,
    required String cpf,
    required String dataNascimento,
    required String sexo,
    required double altura,
    required double peso,
    required double circunferenciaAbdominal,
    required double gorduraCorporal,
    required double massaMuscular,
    required String alergias,
    required String preferencias,
    required String senha,
  }) async {
    var uri = Uri.parse(apiUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields['nome'] = nome;
    request.fields['email'] = email;
    request.fields['cpf'] = cpf;
    request.fields['dataNascimento'] = dataNascimento;
    request.fields['sexo'] = sexo;
    request.fields['altura'] = altura.toString();
    request.fields['peso'] = peso.toString();
    request.fields['circunferenciaAbdominal'] = circunferenciaAbdominal.toString();
    request.fields['gorduraCorporal'] = gorduraCorporal.toString();
    request.fields['massaMuscular'] = massaMuscular.toString();
    request.fields['alergias'] = alergias;
    request.fields['preferencias'] = preferencias;
    request.fields['senha'] = senha;

    var response = await request.send();
    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar paciente');
    }
  }
}

