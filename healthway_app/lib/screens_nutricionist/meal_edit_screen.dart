import 'package:flutter/material.dart';
import 'package:healthway_app/models/alimento.dart';
import 'package:healthway_app/models/refeicao.dart';
import 'package:healthway_app/services/services_facade.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class MealEditScreen extends StatefulWidget {
  final Map<String, dynamic> mealData;
  const MealEditScreen({super.key, required this.mealData});

  @override
  State<MealEditScreen> createState() => _MealEditScreenState();
}

class _MealEditScreenState extends State<MealEditScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _observacoes = '';
  List<Alimento> _availableFoods = [];
  List<Alimento> _selectedFoods = [];
  List<String> _selectedFoodIds = [];
  final ServicesFacade _servicesFacade = ServicesFacade();

  @override
  void initState() {
    super.initState();
    _nome = widget.mealData['refeicao'].nome;
    _observacoes = widget.mealData['refeicao'].observacoes;
    _selectedFoods = widget.mealData['alimentos'];
    _selectedFoodIds = _selectedFoods.map((alimento) => alimento.id).toList();
    _loadAvailableFoods();
  }

  Future<void> _loadAvailableFoods() async {
    try {
      final directory = await getApplicationCacheDirectory();
      final file = File('${directory.path}/alimentos.json');
      if (file.existsSync()) {
        final foodsJson = await file.readAsString();
        final foodsData = jsonDecode(foodsJson) as List<dynamic>;
        final foods = foodsData.map((food) => Alimento.fromJson(food)).toList();
        setState(() {
          _availableFoods = foods;
        });
      } else {
        final foods = await _servicesFacade.obterAlimentos();
        final foodsJson = jsonEncode(foods);
        await file.writeAsString(foodsJson);
        setState(() {
          _availableFoods = foods;
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar alimentos. Tente novamente.'),
        ),
      );
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        var itensDeRefeicao = {};
        for (var alimentoId in _selectedFoodIds) {
          itensDeRefeicao[alimentoId] = "100 g";
        }
        widget.mealData['refeicao'].nome = _nome;
        widget.mealData['refeicao'].observacoes = _observacoes;
        widget.mealData['alimentos'] = itensDeRefeicao;
        Refeicao refeicao = Refeicao.fromJson({
          'id': widget.mealData['refeicao'].id,
          'nome': _nome,
          'observacoes': _observacoes,
          'alimentos': itensDeRefeicao,
        });
        _servicesFacade.atualizar(refeicao);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perfil atualizado com sucesso')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar a refeição. Tente novamente.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editando Refeição'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nome,
                decoration: InputDecoration(labelText: 'Nome da Refeição'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira um nome para a refeição.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nome = value!;
                },
              ),
              TextFormField(
                initialValue: _observacoes,
                decoration: InputDecoration(labelText: 'Observações'),
                onSaved: (value) {
                  _observacoes = value!;
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _availableFoods.length,
                  itemBuilder: (ctx, index) {
                    return CheckboxListTile(
                      title: Text(_availableFoods[index].descricao),
                      value:
                          _selectedFoodIds.contains(_availableFoods[index].id),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedFoodIds.add(_availableFoods[index].id);
                          } else {
                            _selectedFoodIds.remove(_availableFoods[index].id);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
