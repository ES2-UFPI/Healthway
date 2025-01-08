import 'package:flutter/material.dart';
import 'package:healthway_app/geral_screens//apresentationScreen.dart';
import 'package:healthway_app/geral_screens/alimentos_screen.dart';
import 'package:healthway_app/geral_screens/nutricionistas_screen.dart';
import 'package:healthway_app/screens_patient/dashboardScreen.dart';
import 'package:healthway_app/screens_patient/dietScreen.dart';
import 'package:healthway_app/screens_patient/healthScreen.dart';
import 'package:healthway_app/geral_screens//loginScreen.dart';
import 'package:healthway_app/screens_patient/notificationScreen.dart';
import 'package:healthway_app/screens_patient/profileScreen.dart';
import 'package:healthway_app/screens_patient/setingsScreen.dart';
import 'package:healthway_app/screens_patient/signupScreen.dart';

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
        '/home': (context) => PatientDashboardScreen(),
        '/signUp': (context) => CadastroPacienteScreen(),
        '/login': (context) => LoginScreen(),
        '/chat': (context) => ChatScreen(),
        '/health': (context) => DietManagementScreen(),
        '/alimentos': (context) => AlimentosScreen(),
        '/nutricionistas': (context) => NutricionistasScreen(),
        '/menu': (context) => MenuScreen(),
        '/presentation': (context) => PresentationScreen(),
        '/profile': (context) => PatientProfileScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/settings': (context) => SettingsScreen(),
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
