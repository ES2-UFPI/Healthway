import 'package:flutter/material.dart';
import '../models/nutricionista.dart';
import '../services/nutricionista_services.dart';
import '../widgets/nutricionista_item.dart';

class NutricionistasScreen extends StatefulWidget {
  @override
  _NutricionistasScreenState createState() => _NutricionistasScreenState();
}

class _NutricionistasScreenState extends State<NutricionistasScreen> {
  late Future<List<Nutricionista>> _nutricionistas;

  @override
  void initState() {
    super.initState();
    _nutricionistas = NutricionistaService().fetchNutricionistas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nutricionistas')),
      body: FutureBuilder<List<Nutricionista>>(
        future: _nutricionistas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum nutricionista encontrado.'));
          } else {
            var nutricionistas = snapshot.data!;
            return ListView.builder(
              itemCount: nutricionistas.length,
              itemBuilder: (context, index) {
                return NutricionistaItem(nutricionista: nutricionistas[index]);
              },
            );
          }
        },
      ),
    );
  }
}
