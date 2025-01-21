import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:healthway_app/models/paciente.dart';

class PacienteService {
  static const String apiUrl = 'http://localhost:3000/api/pacientes';

  Future<List<Paciente>> fetchPatients() async {
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

  Future<Paciente> fetchPatientById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      try {
        return Paciente.fromJson(json.decode(response.body));
      } catch (e) {
        throw Exception('Erro ao parsear o JSON: $e');
      }
    } else {
      throw Exception('Falha ao carregar paciente');
    }
  }

  Future<List<Paciente>> fetchPatientsByIds(List<String> ids) async {
    var uri = Uri.parse('$apiUrl/list');
    var request = http.Request('POST', uri)
      ..headers['Content-Type'] = 'application/json'
      ..body = json.encode({'ids': ids});
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      List<dynamic>? data = json.decode(responseBody);
      try {
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

  Future<void> registerPatient(Paciente paciente) async {
    var uri = Uri.parse(apiUrl);
    // var request = http.MultipartRequest('POST', uri);

    // request.fields['nome'] = paciente.nome;
    // request.fields['email'] = paciente.email;
    // request.fields['cpf'] = paciente.cpf;
    // request.fields['dt_nascimento'] = paciente.dataNascimento.toString();
    // request.fields['sexo'] = paciente.sexo;
    // request.fields['altura'] = paciente.altura.toString();
    // request.fields['peso'] = paciente.peso.toString();
    // request.fields['circunferencia_abdominal'] =
    //     paciente.circunferenciaAbdominal.toString();
    // request.fields['gordura_corporal'] = paciente.gorduraCorporal.toString();
    // request.fields['massa_muscular'] = paciente.massaMuscular.toString();
    // request.fields['alergias'] = paciente.alergias.toString();
    // request.fields['preferencias'] = paciente.preferencias.toString();
    // request.fields['senha'] = paciente.senha;

    // var response = await request.send();
    // if (response.statusCode != 201) {
    //   throw Exception('Falha ao cadastrar paciente');
    // }

    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': paciente.nome,
        'email': paciente.email,
        'cpf': paciente.cpf,
        'dt_nascimento': paciente.dataNascimento,
        'sexo': paciente.sexo,
        'altura': paciente.altura,
        'peso': paciente.peso,
        'circunferencia_abdominal': paciente.circunferenciaAbdominal,
        'gordura_corporal': paciente.gorduraCorporal,
        'massa_muscular': paciente.massaMuscular,
        'alergias': paciente.alergias,
        'preferencias': paciente.preferencias,
        'senha': paciente.senha,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar paciente');
    }
  }

  Future<bool> login({required String email, required String senha}) async {
    var uri = Uri.parse('$apiUrl/login');
    var request = http.MultipartRequest('POST', uri);

    request.fields['email'] = email;
    request.fields['senha'] = senha;

    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updatePatient(Paciente paciente) async {
    var uri = Uri.parse('$apiUrl/${paciente.id}');
    var response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome': paciente.nome,
        'email': paciente.email,
        'cpf': paciente.cpf,
        'dt_nascimento': paciente.dataNascimento.toString(),
        'sexo': paciente.sexo,
        'altura': paciente.altura.toString(),
        'peso': paciente.peso.toString(),
        'circunferencia_abdominal': paciente.circunferenciaAbdominal.toString(),
        'gordura_corporal': paciente.gorduraCorporal.toString(),
        'massa_muscular': paciente.massaMuscular.toString(),
        'alergias': paciente.alergias,
        'preferencias': paciente.preferencias,
        'senha': paciente.senha,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar paciente');
    }
  }
}
