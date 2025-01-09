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

  @override
  void initState() {
    super.initState();
    futureAlimentos = AlimentoService().fetchAlimentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alimentos'),
      ),
      body: FutureBuilder<List<Alimento>>(
        future: futureAlimentos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum alimento encontrado'));
          } else {
            final alimentos = snapshot.data!;
            return ListView.builder(
              itemCount: alimentos.length,
              itemBuilder: (context, index) {
                return AlimentoItem(alimento: alimentos[index]);
              },
            );
          }
        },
      ),
    );
  }
}
