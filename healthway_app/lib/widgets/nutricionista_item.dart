import 'package:flutter/material.dart';
import 'package:healthway_app/geral_screens/nutricionistas_details_screen.dart';
import '../models/nutricionista.dart';
import '../geral_screens/nutricionistas_details_screen.dart';

class NutricionistaItem extends StatelessWidget {
  final Nutricionista nutricionista;

  const NutricionistaItem({Key? key, required this.nutricionista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            nutricionista.fotoPerfil ??
                'https://www.w3schools.com/w3images/avatar2.png', // Imagem padrão
          ),
        ),
        title: Text(nutricionista.nome),
        subtitle: Text(nutricionista.especialidade),
        onTap: () {
          // Navega para a tela de detalhes do nutricionista
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NutricionistaDetailScreen(nutricionista: nutricionista),
            ),
          );
        },
      ),
    );
  }
}