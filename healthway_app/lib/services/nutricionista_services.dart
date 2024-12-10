// lib/services/nutricionista_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/nutricionista.dart';

class NutricionistaService {
  // Substitua pela URL da sua API
  static const String apiUrl = 'http://localhost:3000/api/nutricionistas';

  Future<List<Nutricionista>> fetchNutricionistas() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta para obter a lista de nutricionistas
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Nutricionista.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar nutricionistas');
    }
  }
}
