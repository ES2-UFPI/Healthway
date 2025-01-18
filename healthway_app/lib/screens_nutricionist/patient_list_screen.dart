import 'package:flutter/material.dart';
import '../models/paciente.dart';
import '../services/paciente_services.dart';
import '../widgets/paciente_item.dart';

class PacientesScreen extends StatefulWidget {
  const PacientesScreen({super.key});

  @override
  _PacientesScreenState createState() => _PacientesScreenState();
}

class _PacientesScreenState extends State<PacientesScreen> {
  late Future<List<Paciente>> _pacientes;
  List<Paciente> pacientes = [];
  List<Paciente> pacientesFiltrados = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarPacientes();
  }

  void _carregarPacientes() {
    setState(() {
      _pacientes = PacienteService().fetchPacientes();
    });
  }

  void _filtrarPacientes(String query) {
    setState(() {
      pacientesFiltrados = pacientes
          .where((paciente) =>
      paciente.nome.toLowerCase().contains(query.toLowerCase()) ||
          paciente.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Pacientes'),
        backgroundColor: Color(0xFF31BAC2),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: FutureBuilder<List<Paciente>>(
              future: _pacientes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Color(0xFF31BAC2)));
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmptyWidget();
                } else {
                  pacientes = snapshot.data!;
                  if (pacientesFiltrados.isEmpty) {
                    pacientesFiltrados = pacientes;
                  }
                  return _buildPacientesList();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _carregarPacientes,
        backgroundColor: Color(0xFF31BAC2),
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xFF31BAC2),
      child: TextField(
        controller: searchController,
        onChanged: _filtrarPacientes,
        decoration: InputDecoration(
          hintText: 'Pesquisar por nome ou email...',
          prefixIcon: Icon(Icons.search, color: Color(0xFF31BAC2)),
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

  Widget _buildPacientesList() {
    return ListView.builder(
      itemCount: pacientesFiltrados.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: PacienteItem(paciente: pacientesFiltrados[index]),
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
            'Erro ao carregar pacientes',
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
          Icon(Icons.person_off, size: 60, color: Color(0xFF31BAC2)),
          SizedBox(height: 16),
          Text(
            'Nenhum paciente encontrado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
