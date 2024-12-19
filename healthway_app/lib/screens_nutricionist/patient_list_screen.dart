import 'package:flutter/material.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Meus Pacientes'),
        backgroundColor: const Color(0xFF31BAC2),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10, // Exemplo com 10 pacientes
          itemBuilder: (context, index) {
            return _buildPatientItem('Paciente ${index + 1}', 'Última consulta: ${10 - index}d atrás');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicionar novo paciente
        },
        backgroundColor: Color(0xFF31BAC2),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPatientItem(String name, String lastConsultation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: Color(0xFF31BAC2),
          child: Text(
            name[0],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          lastConsultation,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        trailing: Icon(Icons.chevron_right, color: Color(0xFF31BAC2)),
        onTap: () {
          // Navegar para os detalhes do paciente
        },
      ),
    );
  }
}

