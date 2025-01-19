import '../models/alimento.dart';
import '../models/nutricionista.dart';
import '../models/paciente.dart';
import 'alimento_services.dart';
import 'nutricionista_services.dart';
import 'paciente_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServicesFacade {
  static const String apiUrl = 'http://localhost:3000/api';
  static const String pacienteUrl = '$apiUrl/pacientes';
  static const String nutricionistaUrl = '$apiUrl/nutricionistas';
  final AlimentoService _alimentoService = AlimentoService();
  final NutricionistaService _nutricionistaService = NutricionistaService();
  final PacienteService _pacienteService = PacienteService();

  // Métodos para AlimentoService
  Future<List<Alimento>> obterAlimentos() async {
    return await _alimentoService.fetchAlimentos();
  }

  // Métodos para NutricionistaService
  Future<List<Nutricionista>> obterNutricionistas() async {
    return await _nutricionistaService.fetchNutricionistas();
  }

  // Métodos para PacienteService
  Future<List<Paciente>> obterPacientes() async {
    return await _pacienteService.fetchPacientes();
  }

  Future<Paciente> obterPacientePorId(String id) async {
    return await _pacienteService.fetchPacienteById(id);
  }

  Future<void> cadastrar(dynamic entity) async {
    if (entity is Nutricionista) {
      await _nutricionistaService.cadastrarNutricionista(entity);
    } else if (entity is Paciente) {
      await _pacienteService.cadastrarPaciente(entity);
    } else {
      throw Exception('Tipo de entidade desconhecido');
    }
  }

  Future<void> atualizar(dynamic entity) async {
    if (entity is Nutricionista) {
      try {
        await _nutricionistaService.atualizarNutricionista(entity);
      } catch (e) {
        throw Exception('Erro ao atualizar Nutricionista: $e');
      }
    } else if (entity is Paciente) {
      try {
        await _pacienteService.atualizarPaciente(entity);
      } catch (e) {
        throw Exception('Erro ao atualizar Paciente: $e');
      }
    } else {
      throw Exception('Tipo de entidade desconhecido');
    }
  }

  Future<dynamic> login(
      {required String email,
      required String senha,
      required String userType}) async {
    Uri uri;
    if (userType == 'Nutricionista') {
      uri = Uri.parse('$nutricionistaUrl/login');
    } else if (userType == 'Paciente') {
      uri = Uri.parse('$pacienteUrl/login');
    } else {
      throw Exception('Tipo de usuário desconhecido');
    }
    var request = http.Request('POST', uri)
      ..headers['Content-Type'] = 'application/json'
      ..body = json.encode({'email': email, 'senha': senha});
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var responseJson = json.decode(responseBody);
      return responseJson;
    } else {
      return null;
    }
  }
}
