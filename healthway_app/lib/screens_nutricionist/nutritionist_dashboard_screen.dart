import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';
class NutritionistDashboardScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const NutritionistDashboardScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSectionTitle('Acesso Rápido'),
              _buildQuickAccess(context),
              _buildSectionTitle('Próximas Consultas', showButton: true, buttonRoute: '/appointments'),
              _buildAppointments(context),
              _buildSectionTitle('Atualizações de Pacientes', showButton: true, buttonRoute: '/patient_updates'),
              _buildPatientUpdates(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData['nome'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Bem-vindo de volta',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/nutricionista.jpg'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildStatsRow(),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem('Pacientes', '${userData['pacientes'].length}'),
          _buildStatItem('Consultas Hoje', '8'),
          _buildStatItem('Mensagens', '15'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildQuickAccess(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuickAccessItem(context, Icons.people, 'Pacientes', '/patient_list', userData),
          _buildQuickAccessItem(context, Icons.calendar_today, 'Agenda', '/schedule', null),
          _buildQuickAccessItem(context, Icons.food_bank_outlined, 'Alimentos', '/alimentos', null),
        ],
      ),
    );
  }

  Widget _buildQuickAccessItem(
      BuildContext context,
      IconData icon,
      String label,
      String route,
      Object? args,
      ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route, arguments: args),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: kPrimaryColor, size: 30),
          ),
          const SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildAppointments(BuildContext context) {
    final appointments = [
      {'name': 'Maria Oliveira', 'time': '14:00', 'type': 'Consulta de Rotina'},
      {'name': 'João Silva', 'time': '15:30', 'type': 'Avaliação Nutricional'},
      {'name': 'Ana Santos', 'time': '17:00', 'type': 'Revisão de Dieta'},
    ];

    return Column(
      children: appointments
          .map((appointment) => _buildAppointmentItem(
        appointment['name']!,
        appointment['time']!,
        appointment['type']!,
      ))
          .toList(),
    );
  }

  Widget _buildAppointmentItem(String name, String time, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: kPrimaryColor, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(type, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              ],
            ),
          ),
          Text(time, style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor)),
        ],
      ),
    );
  }

  Widget _buildPatientUpdates(BuildContext context) {
    final updates = [
      {'name': 'Carlos Mendes', 'update': 'Atingiu meta de peso', 'time': '2h atrás'},
      {'name': 'Fernanda Lima', 'update': 'Novo registro de refeição', 'time': '4h atrás'},
      {'name': 'Ricardo Souza', 'update': 'Solicitou alteração na dieta', 'time': '1d atrás'},
    ];

    return Column(
      children: updates
          .map((update) => _buildPatientUpdateItem(
        update['name']!,
        update['update']!,
        update['time']!,
      ))
          .toList(),
    );
  }

  Widget _buildPatientUpdateItem(String name, String update, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.notifications, color: kPrimaryColor, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(update, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showButton = false, String? buttonRoute}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Pacientes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
      onTap: (index) {
        // Implement navigation logic here
      },
    );
  }
}
