import 'package:flutter/material.dart';
import 'package:healthway_app/geral_screens/nutricionistas_details_screen.dart';

import '../models/nutricionista.dart';

class NutricionistaItem extends StatelessWidget {
  final Nutricionista nutricionista;

  const NutricionistaItem({super.key, required this.nutricionista});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            'https://www.w3schools.com/w3images/avatar2.png', // Imagem padrão
          ),
        ),
        title: Text(
          nutricionista.nome,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(nutricionista.especialidade,
            style: TextStyle(
              color: Colors.white60,
            )),
        onTap: () {
          // Navega para a tela de detalhes do nutricionista
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NutricionistaDetailScreen(nutricionista: nutricionista),
            ),
          );
        },
      ),
    );
  }
}
