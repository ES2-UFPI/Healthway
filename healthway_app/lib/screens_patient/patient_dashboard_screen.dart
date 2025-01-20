import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';

class PatientDashboardScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const PatientDashboardScreen({super.key, required this.userData});

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
              _buildNextAppointment(),
              _buildDailyProgress(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildHeader(context) {
    String name = userData['nome'];
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
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Vamos cuidar da sua saúde hoje!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/patient_profile',
                      arguments: userData);
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: TextStyle(
                        fontSize: 24,
                        backgroundColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
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
                _buildStatItem(
                  'IMC',
                  _calculateBMI(userData['altura'], userData['peso'])
                      .toStringAsFixed(1),
                ),
                _buildStatItem('Peso', '${userData['peso'].toInt()} kg'),
                _buildStatItem('Altura', '${userData['altura'].toInt()} cm'),
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
              color: kTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickAccessItem(context, Icons.restaurant_menu, 'Dieta',
                  '/meal_plan', 'dashboard_dieta', userData),
              _buildQuickAccessItem(context, Icons.people, 'Nutricionistas',
                  '/nutricionistas', 'dashboard_nutricionistas', null),
              // _buildQuickAccessItem(
              //     context, Icons.insert_chart, 'Progresso', '/progress', 'dashboard_', null),
              _buildQuickAccessItem(context, Icons.message, 'Chat', '/chat',
                  'dashboard_chat', null),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessItem(BuildContext context, IconData icon,
      String label, String route, String key, Object? args) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route,
            arguments: args); // Aqui você agora tem acesso ao 'context'
      },
      key: Key(key),
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

  Widget _buildNextAppointment() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
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
                    'Próxima Consulta',
                    style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Dr. Silva - Nutricionista',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '15 Mai\n14:00',
              textAlign: TextAlign.center,
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

  Widget _buildDailyProgress() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progresso Diário',
            style: TextStyle(
              color: kTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          _buildProgressItem('Calorias', 0.7),
          SizedBox(height: 10),
          _buildProgressItem('Água', 0.5),
          SizedBox(height: 10),
          _buildProgressItem('Passos', 0.3),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String label, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ),
      ],
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
            key: Key('bottom_nav_inicio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Dieta',
            key: Key('bottom_nav_dieta'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.insert_chart),
          //   label: 'Progresso',
          //   key: Key('bottom_nav_progresso'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
            key: Key('bottom_nav_perfil'),
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Já estamos na tela inicial, então não faça nada
              break;
            case 1:
              Navigator.pushNamed(context, '/meal_plan', arguments: userData);
              break;
            // case 2:
            //   Navigator.pushNamed(context, '/progress');
            //   break;
            // case 3:
            case 2:
              Navigator.pushNamed(context, '/patient_profile',
                  arguments: userData);
              break;
          }
        },
      ),
    );
  }

  double _calculateBMI(alturaM, peso) {
    var alturaCm = alturaM / 100;
    return peso / (alturaCm * alturaCm);
  }
}
