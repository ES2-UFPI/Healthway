import 'package:flutter/material.dart';
import 'package:healthway_app/constants.dart';
import 'package:healthway_app/services/services_facade.dart';

import '../models/paciente.dart';
import '../widgets/paciente_item.dart';

class PacientesScreen extends StatefulWidget {
  final Map<String, dynamic> args;

  const PacientesScreen({super.key, required this.args});

  @override
  State<PacientesScreen> createState() => _PacientesScreenState();
}

class _PacientesScreenState extends State<PacientesScreen> {
  late Future<List<Paciente>> _pacientes;
  bool initialized = false;
  List<Paciente> pacientes = [];
  List<Paciente> pacientesFiltrados = [];
  TextEditingController searchController = TextEditingController();
  var servicesFacade = ServicesFacade();

  @override
  void initState() {
    super.initState();
    _carregarPacientes();
  }

  void _carregarPacientes() {
    setState(() {
      _pacientes = servicesFacade
          .obterPacientesPorIds(List<String>.from(widget.args['pacientes']));
    });
  }

  void _filtrarPacientes(String query) {
    query = query.trim();
    setState(() {
      pacientesFiltrados = pacientes
          .where((paciente) =>
              paciente.nome.toLowerCase().contains(query.toLowerCase()) ||
              paciente.email.toLowerCase().contains(query.toLowerCase()) ||
              paciente.cpf.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Pacientes'),
        foregroundColor: Colors.white,
        backgroundColor: kPrimaryColor,
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
                  return Center(
                      child: CircularProgressIndicator(color: kPrimaryColor));
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error.toString());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmptyWidget();
                } else {
                  pacientes = snapshot.data!;
                  if (!initialized) {
                    pacientesFiltrados = pacientes;
                    initialized = true;
                  }
                  if (pacientesFiltrados.isEmpty) {
                    return _buildEmptyWidget();
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
        onChanged: _filtrarPacientes,
        style: TextStyle(color: kTextColor, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: 'Pesquisar por nome, email ou CPF...',
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
          Icon(Icons.person_off, size: 60, color: kPrimaryColor),
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
