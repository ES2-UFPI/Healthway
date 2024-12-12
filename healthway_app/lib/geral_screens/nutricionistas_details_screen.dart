import 'package:flutter/material.dart';
import '../models/nutricionista.dart';

class NutricionistaDetailScreen extends StatelessWidget {
  final Nutricionista nutricionista;

  const NutricionistaDetailScreen({Key? key, required this.nutricionista}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nutricionista.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Foto do nutricionista
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                nutricionista.fotoPerfil ??
                    'https://www.w3schools.com/w3images/avatar2.png', // Imagem padrão
              ),
            ),
            const SizedBox(height: 16),
            // Nome
            Text(
              nutricionista.nome,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Especialidade
            Text(
              'Especialidade: ${nutricionista.especialidade}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            // Email
            Text(
              'Email: ${nutricionista.email}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            // CPF
            Text(
              'CPF: ${nutricionista.cpf}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            // CRN
            Text(
              'CRN: ${nutricionista.crn}',
              style: const TextStyle(fontSize: 18),
            ),
            // Outros dados que você achar necessário
          ],
        ),
      ),
    );
  }
}
