import 'package:healthway_app/constants.dart';
import 'package:healthway_app/models/plano_alimentar.dart';
import 'package:healthway_app/models/refeicao.dart';
import 'package:healthway_app/services/plano_alimentar_services.dart';
import 'package:healthway_app/services/refeicao_services.dart';

import '../models/alimento.dart';
import '../models/nutricionista.dart';
import '../models/paciente.dart';
import 'alimento_services.dart';
import 'nutricionista_services.dart';
import 'paciente_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServicesFacade {
  static const String apiUrl = 'https://$domain/api';
  static const String pacienteUrl = '$apiUrl/pacientes';
  static const String nutricionistaUrl = '$apiUrl/nutricionistas';
  final AlimentoService _alimentoService = AlimentoService();
  final NutricionistaService _nutricionistaService = NutricionistaService();
  final PacienteService _pacienteService = PacienteService();
  final PlanoAlimentarService _planoAlimentarService = PlanoAlimentarService();
  final RefeicaoService _refeicaoService = RefeicaoService();

  // Métodos para AlimentoService
  Future<List<Alimento>> obterAlimentos() async {
    return await _alimentoService.fetchFoods();
  }

  Future<Alimento> obterAlimentoPorId(String id) async {
    return await _alimentoService.fetchAlimentoById(id);
  }

  // Métodos para NutricionistaService
  Future<List<Nutricionista>> obterNutricionistas() async {
    return await _nutricionistaService.fetchNutritionists();
  }

  // Métodos para PacienteService
  Future<List<Paciente>> obterPacientes() async {
    return await _pacienteService.fetchPatients();
  }

  Future<Paciente> obterPacientePorId(String id) async {
    return await _pacienteService.fetchPatientById(id);
  }

  Future<List<Paciente>> obterPacientesPorIds(List<String> ids) async {
    return await _pacienteService.fetchPatientsByIds(ids);
  }

  // Métodos para PlanoAlimentarService
  Future<List<dynamic>> obterPlanosPorNutricionista(String id) async {
    return await _planoAlimentarService.fetchPlansByNutritionist(id);
  }

  Future<dynamic> obterPlanoPorPaciente(String id) async {
    return await _planoAlimentarService.fetchPlanByPatient(id);
  }

  Future<void> deletarPlano(String id) async {
    await _planoAlimentarService.deletePlan(id);
  }

  // Métodos para RefeicaoService
  Future<dynamic> obterRefeicaoPorId(String id) async {
    return await _refeicaoService.fetchMealById(id);
  }

  Future<void> deletarRefeicao(String id) async {
    await _refeicaoService.deleteMeal(id);
  }

  Future<void> cadastrar(dynamic entity) async {
    if (entity is Nutricionista) {
      await _nutricionistaService.registerNutritionist(entity);
    } else if (entity is Paciente) {
      await _pacienteService.registerPatient(entity);
    } else if (entity is PlanoAlimentar) {
      await _planoAlimentarService.registerPlan(entity);
    } else if (entity is Refeicao) {
      await _refeicaoService.registerMeal(entity);
    } else {
      throw Exception('Tipo de entidade desconhecido');
    }
  }

  Future<void> atualizar(dynamic entity) async {
    if (entity is Nutricionista) {
      try {
        await _nutricionistaService.updateNutritionist(entity);
      } catch (e) {
        throw Exception('Erro ao atualizar Nutricionista: $e');
      }
    } else if (entity is Paciente) {
      try {
        await _pacienteService.updatePatient(entity);
      } catch (e) {
        throw Exception('Erro ao atualizar Paciente: $e');
      }
    } else if (entity is PlanoAlimentar) {
      try {
        await _planoAlimentarService.updatePlan(entity);
      } catch (e) {
        throw Exception('Erro ao atualizar Plano Alimentar: $e');
      }
    } else if (entity is Refeicao) {
      try {
        await _refeicaoService.updateMeal(entity);
      } catch (e) {
        throw Exception('Erro ao atualizar Refeição: $e');
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
