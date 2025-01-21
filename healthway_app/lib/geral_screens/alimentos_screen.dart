import 'package:flutter/material.dart';
import '../services/alimento_services.dart';
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
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarAlimentos();
  }

  void _carregarAlimentos() {
    setState(() {
      futureAlimentos = AlimentoService().fetchAlimentos();
    });
  }

  void _filtrarAlimentos(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      alimentosFiltrados = alimentos.where((alimento) {
        return alimento.descricao.toLowerCase().contains(lowerQuery) ||
            alimento.categoria.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: FutureBuilder<List<Alimento>>(
              future: futureAlimentos,
              builder: (context, snapshot) => _buildBody(snapshot),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _carregarAlimentos,
        child: const Icon(Icons.refresh),
        backgroundColor: const Color(0xFF31BAC2),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Alimentos'),
      backgroundColor: const Color(0xFF31BAC2),
      elevation: 5,
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF31BAC2),
      child: TextField(
        controller: searchController,
        onChanged: _filtrarAlimentos,
        decoration: InputDecoration(
          hintText: 'Pesquisar alimentos...',
          prefixIcon: const Icon(Icons.search, color: Color(0xFF31BAC2)),
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

  Widget _buildBody(AsyncSnapshot<List<Alimento>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF31BAC2)),
      );
    } else if (snapshot.hasError) {
      return _buildErrorWidget(snapshot.error.toString());
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return _buildEmptyWidget();
    } else {
      alimentos = snapshot.data!;
      if (alimentosFiltrados.isEmpty) alimentosFiltrados = alimentos;
      return _buildAlimentosList();
    }
  }

  Widget _buildAlimentosList() {
    return ListView.builder(
      itemCount: alimentosFiltrados.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Colors.black.withOpacity(0.2),
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
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Erro ao carregar alimentos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
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
          const Icon(Icons.no_food, size: 60, color: Color(0xFF31BAC2)),
          const SizedBox(height: 16),
          const Text(
            'Nenhum alimento encontrado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
