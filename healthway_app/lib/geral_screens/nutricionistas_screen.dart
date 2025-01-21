import 'package:flutter/material.dart';
import 'package:healthway_app/constants.dart';
import 'package:healthway_app/services/services_facade.dart';

import '../models/nutricionista.dart';
import '../widgets/nutricionista_item.dart';

class NutricionistasScreen extends StatefulWidget {
  const NutricionistasScreen({super.key});

  @override
  State<NutricionistasScreen> createState() => _NutricionistasScreenState();
}

class _NutricionistasScreenState extends State<NutricionistasScreen> {
  late Future<List<Nutricionista>> _nutricionistas;
  List<Nutricionista> nutricionistas = [];
  List<Nutricionista> nutricionistasFiltrados = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarNutricionistas();
  }

  void _carregarNutricionistas() {
    setState(() {
      _nutricionistas = ServicesFacade().obterNutricionistas();
    });
  }

  void _filtrarNutricionistas(String query) {
    setState(() {
      nutricionistasFiltrados = nutricionistas
          .where((nutricionista) =>
              nutricionista.nome.toLowerCase().contains(query.toLowerCase()) ||
              nutricionista.especialidade
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Nutricionistas'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: FutureBuilder<List<Nutricionista>>(
              future: _nutricionistas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(color: kPrimaryColor));
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmptyWidget();
                } else {
                  nutricionistas = snapshot.data!;
                  if (nutricionistasFiltrados.isEmpty) {
                    nutricionistasFiltrados = nutricionistas;
                  }
                  return _buildNutricionistasList();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _carregarNutricionistas,
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
        onChanged: _filtrarNutricionistas,
        decoration: InputDecoration(
          hintText: 'Pesquisar por nome ou especialidade...',
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

  Widget _buildNutricionistasList() {
    return ListView.builder(
      itemCount: nutricionistasFiltrados.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: NutricionistaItem(
                nutricionista: nutricionistasFiltrados[index]),
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
            'Erro ao carregar nutricionistas',
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
          Icon(Icons.person_off, size: 60, color: kPrimaryColor),
          SizedBox(height: 16),
          Text(
            'Nenhum nutricionista encontrado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
