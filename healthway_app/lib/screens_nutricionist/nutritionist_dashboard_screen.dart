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
              _buildHeader(context),
              _buildQuickAccess(context),
              _buildAppointments(context),
              _buildPatientUpdates(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Bem-vindo de volta',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/nutritionistProfile');
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          ),
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
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccess(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Acesso Rápido',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickAccessItem(context, Icons.people, 'Pacientes',
                  '/patient_list', userData),
              _buildQuickAccessItem(
                  context, Icons.calendar_today, 'Agenda', '/schedule', null),
              // _buildQuickAccessItem(
              //     context, Icons.restaurant_menu, 'Planos', '/meal_plans'),
              _buildQuickAccessItem(context, Icons.food_bank_outlined,
                  'Alimentos', '/alimentos', null),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessItem(BuildContext context, IconData icon,
      String label, String route, Object? args) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route, arguments: args);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: kPrimaryColor,
              size: 30,
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointments(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Próximas Consultas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/appointments');
                },
                child: Text(
                  'Ver todas',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          _buildAppointmentItem(
              context, 'Maria Oliveira', '14:00', 'Consulta de Rotina'),
          _buildAppointmentItem(
              context, 'João Silva', '15:30', 'Avaliação Nutricional'),
          _buildAppointmentItem(
              context, 'Ana Santos', '17:00', 'Revisão de Dieta'),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(
      BuildContext context, String name, String time, String type) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/appointment_details',
            arguments: {'name': name, 'time': time, 'type': type});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPrimaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.calendar_today,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    type,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientUpdates(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Atualizações de Pacientes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/patient_updates');
                },
                child: Text(
                  'Ver todas',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          _buildPatientUpdateItem(
              context, 'Carlos Mendes', 'Atingiu meta de peso', '2h atrás'),
          _buildPatientUpdateItem(context, 'Fernanda Lima',
              'Novo registro de refeição', '4h atrás'),
          _buildPatientUpdateItem(context, 'Ricardo Souza',
              'Solicitou alteração na dieta', '1d atrás'),
        ],
      ),
    );
  }

  Widget _buildPatientUpdateItem(
      BuildContext context, String name, String update, String time) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/patient_details',
            arguments: {'name': name});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: kPrimaryColor.withValues(alpha: 0.1),
              child: Text(
                name[0],
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    update,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on home screen
              break;
            case 1:
              Navigator.pushNamed(context, '/patientList');
              break;
            case 2:
              Navigator.pushNamed(context, '/schedule');
              break;
            case 3:
              Navigator.pushNamed(context, '/chat');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pacientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensagens',
          ),
        ],
      ),
    );
  }
}
