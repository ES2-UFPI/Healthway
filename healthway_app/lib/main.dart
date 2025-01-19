import 'package:flutter/material.dart';
import 'package:healthway_app/geral_screens/alimentos_screen.dart';
import 'package:healthway_app/geral_screens/loginScreen.dart';
import 'package:healthway_app/geral_screens/nutricionistas_screen.dart';
import 'package:healthway_app/geral_screens/presentation_screen.dart';
import 'package:healthway_app/screens_nutricionist/meal_plan_screen.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_dashboard_screen.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_profile.dart';
import 'package:healthway_app/screens_nutricionist/patient_list_screen.dart';
import 'package:healthway_app/screens_nutricionist/schedule_screen.dart';
import 'package:healthway_app/screens_nutricionist/signup_nutritionist_screen.dart';
import 'package:healthway_app/screens_patient/patient_dashboard_screen.dart';
import 'package:healthway_app/screens_patient/dietScreen.dart';
import 'package:healthway_app/screens_patient/notificationScreen.dart';
import 'package:healthway_app/screens_patient/patient_profile_screen.dart';
import 'package:healthway_app/screens_patient/setingsScreen.dart';
import 'package:healthway_app/screens_patient/signup_patient_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Dashboard',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF4CAF50),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF4CAF50),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode:
          ThemeMode.system, // Alterna automaticamente entre claro e escuro
      initialRoute: '/',
      routes: {
        '/': (context) => PresentationScreen(),
        '/signup_patient': (context) => CadastroPacienteScreen(),
        '/signup_nutritionist': (context) => CadastroNutricionistaScreen(),
        '/login': (context) => LoginScreen(),
        '/chat': (context) => ChatScreen(),
        '/health': (context) => PlanoAlimentarScreen(
              pacienteId: '',
            ),
        '/alimentos': (context) => AlimentosScreen(),
        '/nutricionistas': (context) => NutricionistasScreen(),
        '/menu': (context) => MenuScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/settings': (context) => SettingsScreen(),
        '/patientList': (context) => PatientListScreen(),
        '/nutritionistProfile': (context) => NutritionistProfileScreen(),
        '/schedule': (context) => ScheduleScreen(),
        '/meal_plans': (context) => MealPlanScreen(
              patientName: '',
            ),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home_patient':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PatientDashboardScreen(userData: args),
            );
          case '/home_nutritionist':
            return MaterialPageRoute(
              builder: (context) => NutritionistDashboardScreen(),
            );
          case '/patient_profile':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PatientProfileScreen(userData: args),
            );
          default:
            return null;
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Center(child: Text('Tela Inicial')),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Center(child: Text('Tela de Chat')),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Center(child: Text('Tela de Menu')),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color(0xFF31BAC2),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Saúde',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Menu',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/chat');
            break;
          case 2:
            Navigator.pushNamed(context, '/health');
            break;
          case 3:
            Navigator.pushNamed(context, '/settings');
            break;
        }
      },
    );
  }
}
