import 'package:flutter/material.dart';
import '../models/alimento.dart';

class AlimentoItem extends StatelessWidget {
  final Alimento alimento;

  AlimentoItem({required this.alimento});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(Icons.food_bank), // Ícone do alimento
        title: Text(
          alimento.nome,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Porção: ${alimento.porcao}'),
            Text('Peso: ${alimento.peso}g'),
            Text('Calorias: ${alimento.calorias} kcal'),
            Text('Carboidratos: ${alimento.carboidratos}g'),
            Text('Proteínas: ${alimento.proteinas}g'),
            Text('Gordura: ${alimento.gordura}g'),
          ],
        ),
        isThreeLine: true, // Permite que o conteúdo ocupe 3 linhas
        onTap: () {
          // Ação quando o item é tocado, por exemplo, abrir detalhes
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(alimento.nome),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Porção: ${alimento.porcao}'),
                    Text('Peso: ${alimento.peso}g'),
                    Text('Calorias: ${alimento.calorias} kcal'),
                    Text('Carboidratos: ${alimento.carboidratos}g'),
                    Text('Proteínas: ${alimento.proteinas}g'),
                    Text('Gordura: ${alimento.gordura}g'),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Fechar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
