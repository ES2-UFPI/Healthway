import 'package:flutter/material.dart';
import '../models/paciente.dart';

class PacienteItem extends StatelessWidget {
  final Paciente paciente;

  const PacienteItem({Key? key, required this.paciente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Icon(
          Icons.person,
          color: Colors.grey[700],
        ),
      ),
      title: Text(
        paciente.nome,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Text('Email: ${paciente.email}'),
          Text('CPF: ${paciente.cpf}'),
        ],
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[700],
      ),
      onTap: () {
        // Ação ao clicar no item (Exemplo: abrir detalhes do paciente)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PacienteDetalhesScreen(paciente: paciente),
          ),
        );
      },
    );
  }
}

class PacienteDetalhesScreen extends StatelessWidget {
  final Paciente paciente;

  const PacienteDetalhesScreen({Key? key, required this.paciente})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Paciente'),
        backgroundColor: Color(0xFF31BAC2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              paciente.nome,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text('Email: ${paciente.email}'),
            Text('CPF: ${paciente.cpf}'),
            Text('Data de Nascimento: ${paciente.dataNascimento}'),
            Text('Sexo: ${paciente.sexo}'),
            Text('Altura: ${paciente.altura} m'),
            Text('Peso: ${paciente.peso} kg'),
            Text(
                'Circunferência Abdominal: ${paciente.circunferenciaAbdominal} cm'),
            Text('Gordura Corporal: ${paciente.gorduraCorporal}%'),
            Text('Massa Muscular: ${paciente.massaMuscular} kg'),
            SizedBox(height: 16),
            Text(
              'Alergias:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: paciente.alergias
                  .map((alergia) => Text('- $alergia'))
                  .toList(),
            ),
            SizedBox(height: 16),
            Text(
              'Preferências:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: paciente.preferencias
                  .map((preferencia) => Text('- $preferencia'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
