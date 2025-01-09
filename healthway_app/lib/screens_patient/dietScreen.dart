import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanoAlimentarScreen extends StatefulWidget {
  final String pacienteId;

  const PlanoAlimentarScreen({Key? key, required this.pacienteId}) : super(key: key);

  @override
  _PlanoAlimentarScreenState createState() => _PlanoAlimentarScreenState();
}

class _PlanoAlimentarScreenState extends State<PlanoAlimentarScreen> {
  List<PlanoAlimentar> planosAlimentares = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarPlanosAlimentares();
  }

  Future<void> _carregarPlanosAlimentares() async {
    // Simular uma chamada de API
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      planosAlimentares = [
        PlanoAlimentar(
          consulta: 'Consulta 1',
          dtInicio: DateTime.now(),
          dtFim: DateTime.now().add(Duration(days: 30)),
          refeicoes: [
            Refeicao('Café da Manhã', ['2 fatias de pão integral', '1 ovo cozido', '1 maçã']),
            Refeicao('Almoço', ['150g de frango grelhado', '1 xícara de arroz integral', 'Salada verde']),
            Refeicao('Jantar', ['150g de peixe assado', '1 batata doce média', 'Legumes no vapor']),
          ],
          paciente: widget.pacienteId,
        ),
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Plano Alimentar', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF31BAC2),
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF31BAC2)))
          : planosAlimentares.isEmpty
          ? _buildEmptyState()
          : _buildPlanoAlimentarList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementar a criação de um novo plano alimentar
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF31BAC2),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.no_meals, size: 80, color: Color(0xFF31BAC2)),
          SizedBox(height: 16),
          Text(
            'Nenhum plano alimentar encontrado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Clique no botão + para adicionar um novo plano',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanoAlimentarList() {
    return ListView.builder(
      itemCount: planosAlimentares.length,
      itemBuilder: (context, index) {
        final plano = planosAlimentares[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ExpansionTile(
            title: Text(
              plano.consulta,
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF31BAC2)),
            ),
            subtitle: Text(
              '${DateFormat('dd/MM/yyyy').format(plano.dtInicio)} - ${DateFormat('dd/MM/yyyy').format(plano.dtFim)}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            children: plano.refeicoes.map((refeicao) => _buildRefeicaoItem(refeicao)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildRefeicaoItem(Refeicao refeicao) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            refeicao.nome,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 4),
          ...refeicao.alimentos.map((alimento) => Padding(
            padding: const EdgeInsets.only(left: 16, top: 2),
            child: Text('• $alimento'),
          )),
        ],
      ),
    );
  }
}

class PlanoAlimentar {
  final String consulta;
  final DateTime dtInicio;
  final DateTime dtFim;
  final List<Refeicao> refeicoes;
  final String paciente;

  PlanoAlimentar({
    required this.consulta,
    required this.dtInicio,
    required this.dtFim,
    required this.refeicoes,
    required this.paciente,
  });
}

class Refeicao {
  final String nome;
  final List<String> alimentos;

  Refeicao(this.nome, this.alimentos);
}

