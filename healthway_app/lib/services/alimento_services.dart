import 'dart:convert';
import 'package:healthway_app/constants.dart';
import 'package:http/http.dart' as http;
import '../models/alimento.dart';

class AlimentoService {
  final String apiUrl = 'http://$domain/api/alimentos';

  Future<List<Alimento>> fetchFoods() async {
    // Fazendo a requisição HTTP para o endpoint da API
    final response = await http.get(Uri.parse(apiUrl));

    // Verificando o status da resposta
    if (response.statusCode == 200) {
      // Se a requisição for bem-sucedida, parseia o JSON
      final List<dynamic> jsonData = json.decode(response.body);

      // Mapeia os dados JSON para objetos Alimento
      return jsonData.map((item) => Alimento.fromJson(item)).toList();
    } else {
      // Em caso de erro, lança uma exceção
      throw Exception('Falha ao carregar os alimentos');
    }
  }

  Future<Alimento> fetchAlimentoById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return Alimento.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar o alimento');
    }
  }
}
