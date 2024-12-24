import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/nutricionista.dart';
import 'dart:io';

class NutricionistaService {
  static const String apiUrl = 'http://localhost:3000/api/nutricionistas';

  Future<List<Nutricionista>> fetchNutricionistas() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      try {
        List<dynamic> data = json.decode(response.body);

        if (data != null && data is List) {
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

  Future<void> cadastrarNutricionista({
    required String nome,
    required String email,
    required String cpf,
    required String crn,
    required String especialidade,
    required File fotoPerfil,
    required File fotoDocumento,
    required String senha,
  }) async {
    var uri = Uri.parse('$apiUrl');
    var request = http.MultipartRequest('POST', uri);

    request.fields['nome'] = nome;
    request.fields['email'] = email;
    request.fields['cpf'] = cpf;
    request.fields['crn'] = crn;
    request.fields['especialidade'] = especialidade;
    request.fields['senha'] = senha;

    request.files.add(await http.MultipartFile.fromPath('foto_perfil', fotoPerfil.path));
    request.files.add(await http.MultipartFile.fromPath('foto_documento', fotoDocumento.path));

    var response = await request.send();
    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar nutricionista');
    }
  }
}

