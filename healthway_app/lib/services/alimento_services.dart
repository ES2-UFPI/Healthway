import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/alimentos.dart';

class AlimentoService {
  static const String apiUrl = 'http://localhost:3000/api/alimentos';

  Future<List<Alimento>> fetchAlimentos() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Decodifica o corpo da resposta para obter a lista de alimentos
        List<dynamic> data = json.decode(response.body);

        // Converte os dados em objetos Alimento, tratando valores nulos
        return data.map((json) {
          try {
            return Alimento.fromJson(json);
          } catch (e) {
            print('Erro ao parse JSON: $e');
            return null; // Retorna null caso haja erro na conversão
          }
        }).whereType<Alimento>().toList(); // Ignora objetos null
      } else {
        throw Exception('Falha ao carregar alimentos');
      }
    } catch (e) {
      throw Exception('Falha ao carregar alimentos: $e');
    }
  }
}
