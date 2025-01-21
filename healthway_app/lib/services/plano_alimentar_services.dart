import 'dart:convert';
import 'package:healthway_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:healthway_app/models/plano_alimentar.dart';

class PlanoAlimentarService {
  static const String apiUrl = 'https://$domain/api/planos-alimentares';

  Future<List<PlanoAlimentar>> fetchPlansByNutritionist(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/nutricionista/$id'));

    if (response.statusCode == 200) {
      try {
        List<dynamic>? data = json.decode(response.body);

        if (data != null) {
          return data.map((json) => PlanoAlimentar.fromJson(json)).toList();
        } else {
          throw Exception('Dados não encontrados ou formato inválido');
        }
      } catch (e) {
        throw Exception('Erro ao parsear o JSON: $e');
      }
    } else {
      throw Exception('Falha ao carregar Planos Alimentares');
    }
  }

  Future<PlanoAlimentar> fetchPlanByPatient(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/paciente/$id'));

    if (response.statusCode == 200) {
      try {
        dynamic data = json.decode(response.body);

        if (data != null) {
          return PlanoAlimentar.fromJson(data[0]);
        } else {
          throw Exception('Dados não encontrados ou formato inválido');
        }
      } catch (e) {
        throw Exception('Erro ao parsear o JSON: $e');
      }
    } else {
      throw Exception('Falha ao carregar Plano Alimentar');
    }
  }

  Future<void> registerPlan(PlanoAlimentar plano) async {
    var uri = Uri.parse(apiUrl);

    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(plano.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao cadastrar Plano Alimentar');
    }
  }

  Future<void> updatePlan(PlanoAlimentar plano) async {
    var uri = Uri.parse('$apiUrl/${plano.id}');
    var response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(plano.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar Plano Alimentar');
    }
  }

  Future<void> deletePlan(String id) async {
    var uri = Uri.parse('$apiUrl/$id');
    var response = await http.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar Plano Alimentar');
    }
  }
}
