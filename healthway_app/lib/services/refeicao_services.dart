import 'dart:convert';
import 'package:healthway_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:healthway_app/models/refeicao.dart';

class RefeicaoService {
  static const String apiUrl = 'http://$domain/api/refeicoes';

  Future<Refeicao> fetchMealById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic>? data = json.decode(response.body);

        if (data != null) {
          return Refeicao.fromJson(data);
        } else {
          throw Exception('Dados não encontrados ou formato inválido');
        }
      } catch (e) {
        throw Exception('Erro ao parsear o JSON: $e');
      }
    } else {
      throw Exception('Falha ao carregar Refeição');
    }
  }

  Future<void> registerMeal(Refeicao refeicao) async {
    var uri = Uri.parse(apiUrl);

    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(refeicao.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar Refeição');
    }
  }

  Future<void> updateMeal(Refeicao refeicao) async {
    var uri = Uri.parse('$apiUrl/${refeicao.id}');
    var response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(refeicao.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar Refeição');
    }
  }

  Future<void> deleteMeal(String id) async {
    var uri = Uri.parse('$apiUrl/$id');
    var response = await http.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar Refeição');
    }
  }
}
