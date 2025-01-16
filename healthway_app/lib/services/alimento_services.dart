import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/alimento.dart';

class AlimentoService {
  Future<List<Alimento>> fetchAlimentos() async {
    // Fazendo a requisição HTTP para o endpoint da API
    final response = await http.get(Uri.parse('http://localhost:3000/api/alimentos'));

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
}
