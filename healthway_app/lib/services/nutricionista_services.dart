import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/nutricionista.dart';

class NutricionistaService {
  static const String apiUrl = 'http://localhost:3000/api/nutricionistas';

  Future<List<Nutricionista>> fetchNutricionistas() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      try {
        List<dynamic>? data = json.decode(response.body);

        if (data != null) {
          return data.map((json) => Nutricionista.fromJson(json)).toList();
        } else {
          throw Exception('Dados não encontrados ou formato inválido');
        }
      } catch (e) {
        throw Exception('Erro ao parsear o JSON: $e');
      }
    } else {
      throw Exception('Falha ao carregar nutricionistas');
    }
  }

  Future<void> cadastrarNutricionista(Nutricionista nutricionista) async {
    var uri = Uri.parse(apiUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields['nome'] = nutricionista.nome;
    request.fields['email'] = nutricionista.email;
    request.fields['cpf'] = nutricionista.cpf;
    request.fields['crn'] = nutricionista.crn;
    request.fields['especialidade'] = nutricionista.especialidade;
    request.fields['senha'] = nutricionista.senha;

    // request.files
    //     .add(await http.MultipartFile.fromPath('foto_perfil', fotoPerfil.path));
    // request.files.add(await http.MultipartFile.fromPath(
    //     'foto_documento', fotoDocumento.path));

    var response = await request.send();
    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar nutricionista');
    }
  }

  Future<void> atualizarNutricionista(Nutricionista nutricionista) async {
    var uri = Uri.parse('$apiUrl/${nutricionista.id}');
    var request = http.MultipartRequest('PUT', uri);

    request.fields['nome'] = nutricionista.nome;
    request.fields['email'] = nutricionista.email;
    request.fields['cpf'] = nutricionista.cpf;
    request.fields['crn'] = nutricionista.crn;
    request.fields['especialidade'] = nutricionista.especialidade;
    request.fields['senha'] = nutricionista.senha;

    // request.files
    //     .add(await http.MultipartFile.fromPath('foto_perfil', fotoPerfil.path));
    // request.files.add(await http.MultipartFile.fromPath(
    //     'foto_documento', fotoDocumento.path));

    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar nutricionista');
    }
  }
}
