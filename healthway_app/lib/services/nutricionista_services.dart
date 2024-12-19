import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/nutricionista.dart';

class NutricionistaService {
  static const String apiUrl = 'http://localhost:3000/api/nutricionistas';

  Future<List<Nutricionista>> fetchNutricionistas() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      try {
        // Decodifica o corpo da resposta
        List<dynamic> data = json.decode(response.body);

        // Verifica se os dados não são nulos e se são uma lista
        if (data != null && data is List) {
          return data.map((json) => Nutricionista.fromJson(json)).toList();
        } else {
          // Caso os dados sejam nulos ou não sejam uma lista
          throw Exception('Dados não encontrados ou formato inválido');
        }
      } catch (e) {
        throw Exception('Erro ao parsear o JSON: $e');
      }
    } else {
      throw Exception('Falha ao carregar nutricionistas');
    }
  }
}
