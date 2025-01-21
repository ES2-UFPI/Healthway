import 'package:flutter/material.dart';
import 'package:healthway_app/constants.dart';
import 'package:healthway_app/models/alimento.dart';
import 'package:healthway_app/models/plano_alimentar.dart';
import 'package:healthway_app/models/refeicao.dart';
import 'package:healthway_app/services/services_facade.dart';
import 'package:intl/intl.dart';

class MealPlanScreen extends StatefulWidget {
  final Map<String, dynamic> patientData;
  final bool isPatient;

  const MealPlanScreen(
      {super.key, required this.patientData, required this.isPatient});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final ServicesFacade _servicesFacade = ServicesFacade();
  late Future<Map<String, dynamic>> _mealPlanData;
  late String patientId;
  final Map<dynamic, dynamic> _planData = {};

  void carregarPlanoAlimentar() {
    setState(() {
      _mealPlanData = _fetchMealPlanData();
    });
  }

  @override
  void initState() {
    super.initState();
    patientId = widget.patientData['id'];
    carregarPlanoAlimentar();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   carregarPlanoAlimentar();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
            'Plano Alimentar${widget.isPatient ? '' : ' - ${widget.patientData['nome']}'}'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _mealPlanData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar dados'));
            } else {
              final mealPlanData = snapshot.data as Map<String, dynamic>;
              final planoAlimentar =
                  mealPlanData['plano_alimentar'] as PlanoAlimentar;
              final refeicoes = mealPlanData['refeicoes'] as List<dynamic>;
              final itensDeRefeicao = mealPlanData['itens_de_refeicao']
                  as Map<String, Map<String, String>>;
              final alimentos = mealPlanData['alimentos'];

              return ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  ListTile(
                    title: Text(
                      'Início: ${DateFormat('dd/MM/yyyy').format(planoAlimentar.dtInicio)} - Fim: ${DateFormat('dd/MM/yyyy').format(planoAlimentar.dtFim)}',
                      // textAlign: TextAlign.center,
                    ),
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey[400]),
                  ),
                  ...refeicoes.map((refeicao) {
                    return Card(
                      elevation: 4.0,
                      color: Colors.white,
                      child: ListTile(
                        title: Text(
                          refeicao.nome,
                        ),
                        titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kPrimaryColor,
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (refeicao.observacoes != null &&
                                  refeicao.observacoes!.isNotEmpty)
                                Text(
                                  '${refeicao.observacoes}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: kTextColor.withValues(alpha: 0.8)),
                                ),
                              ...itensDeRefeicao[refeicao.id]!.entries.map(
                                    (itemDeRefeicao) => Text(
                                      '${itemDeRefeicao.key}: ${itemDeRefeicao.value}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: kTextColor),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                        trailing: widget.isPatient
                            ? null
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editMeal(refeicao, alimentos[refeicao.id]);
                                },
                              ),
                      ),
                    );
                  }),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: carregarPlanoAlimentar,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchMealPlanData() async {
    final planoAlimentar = await _servicesFacade
        .obterPlanoPorPaciente(patientId) as PlanoAlimentar;
    final refeicoes = List<Refeicao>.from(await Future.wait(planoAlimentar
        .refeicoes
        .map((id) => _servicesFacade.obterRefeicaoPorId(id))
        .toList()));
    final Map<String, Map<String, String>> itensDeRefeicao = {};
    final Map<String, List<Alimento>> alimentos = {};
    for (var refeicao in refeicoes) {
      Map<String, String> novosItensDeRefeicao = {};
      List<Alimento> novosAlimentos = [];

      for (var alimentoId in refeicao.alimentos.entries) {
        final Alimento alimento =
            await _servicesFacade.obterAlimentoPorId(alimentoId.key);
        novosItensDeRefeicao[alimento.descricao] = alimentoId.value;
        novosAlimentos.add(alimento);
      }
      itensDeRefeicao[refeicao.id!] = novosItensDeRefeicao;
      alimentos[refeicao.id!] = novosAlimentos;
    }

    return {
      'plano_alimentar': planoAlimentar,
      'refeicoes': refeicoes,
      'itens_de_refeicao': itensDeRefeicao,
      'alimentos': alimentos,
    };
  }

  void _editMeal(Refeicao refeicao, List<Alimento> alimentos) {
    _planData[refeicao.id] = {'refeicao': refeicao, 'alimentos': alimentos};
    Navigator.pushNamed(context, '/meal_edit',
        arguments: _planData[refeicao.id]);
  }
}
