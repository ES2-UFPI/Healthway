import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthway_app/constants.dart';
import 'package:healthway_app/services/services_facade.dart';
import 'package:path_provider/path_provider.dart';

import '../models/alimento.dart';
import '../widgets/alimento_item.dart';

class AlimentosScreen extends StatefulWidget {
  const AlimentosScreen({super.key});

  @override
  State<AlimentosScreen> createState() => _AlimentosScreenState();
}

class _AlimentosScreenState extends State<AlimentosScreen> {
  late Future<List<Alimento>> futureAlimentos;
  List<Alimento> alimentos = [];
  List<Alimento> alimentosFiltrados = [];
  TextEditingController searchController = TextEditingController();
  final ServicesFacade _servicesFacade = ServicesFacade();

  @override
  void initState() {
    super.initState();
    _carregarAlimentos();
  }

  void _carregarAlimentos() {
    setState(() {
      futureAlimentos = _downloadAlimentos();
    });
  }

  Future<List<Alimento>> _downloadAlimentos() async {
    try {
      final directory = await getApplicationCacheDirectory();
      final file = File('${directory.path}/alimentos.json');
      if (file.existsSync()) {
        final foodsJson = await file.readAsString();
        final foodsData = jsonDecode(foodsJson) as List<dynamic>;
        final foods = foodsData.map((food) => Alimento.fromJson(food)).toList();
        return foods;
      } else {
        final foods = await _servicesFacade.obterAlimentos();
        final foodsJson = jsonEncode(foods);
        await file.writeAsString(foodsJson);
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao baixar alimentos. Tente novamente.'),
        ),
      );
      return [];
    }
    return [];
  }

  void _filtrarAlimentos(String query) {
    setState(() {
      alimentosFiltrados = alimentos.where((alimento) {
        final descricaoMatch =
            alimento.descricao.toLowerCase().contains(query.toLowerCase());
        return descricaoMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Alimentos'),
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
        elevation: 5,
        // Remover o arredondamento da parte superior do AppBar
        shape: null,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: FutureBuilder<List<Alimento>>(
              future: futureAlimentos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(color: kPrimaryColor));
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmptyWidget();
                } else {
                  alimentos = snapshot.data!;
                  if (alimentosFiltrados.isEmpty) {
                    alimentosFiltrados = alimentos;
                  }
                  return _buildAlimentosList();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _carregarAlimentos,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(16),
      color: kPrimaryColor,
      child: TextField(
        controller: searchController,
        onChanged: _filtrarAlimentos,
        decoration: InputDecoration(
          hintText: 'Pesquisar alimentos...',
          prefixIcon: Icon(Icons.search, color: kPrimaryColor),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildAlimentosList() {
    return ListView.builder(
      itemCount: alimentosFiltrados.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Colors.black.withValues(alpha: 0.2),
            color: Colors
                .transparent, // Garantir que o fundo do card seja transparente
            child: AlimentoItem(alimento: alimentosFiltrados[index]),
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: Colors.red),
          SizedBox(height: 16),
          Text(
            'Erro ao carregar alimentos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.no_food, size: 60, color: kPrimaryColor),
          SizedBox(height: 16),
          Text(
            'Nenhum alimento encontrado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

extension on Color {
  withValues({required double alpha}) {}
}
