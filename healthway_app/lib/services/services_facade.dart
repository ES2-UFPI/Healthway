import '../models/alimento.dart';
import '../models/nutricionista.dart';
import '../models/paciente.dart';
import 'alimento_services.dart';
import 'nutricionista_services.dart';
import 'paciente_services.dart';

class ServicesFacade {
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

  Future<void> cadastrar(dynamic entity) async {
    if (entity is Nutricionista) {
      await _nutricionistaService.cadastrarNutricionista(entity);
    } else if (entity is Paciente) {
      await _pacienteService.cadastrarPaciente(entity);
    } else {
      throw Exception('Tipo de entidade desconhecido');
    }
  }
}
