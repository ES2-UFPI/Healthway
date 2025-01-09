import 'package:flutter/material.dart';
import 'package:healthway_app/geral_screens//loginScreen.dart';
import 'package:healthway_app/geral_screens/alimentos_screen.dart';
import 'package:healthway_app/geral_screens/nutricionistas_screen.dart';
import 'package:healthway_app/geral_screens/presentationScreen.dart';
import 'package:healthway_app/screens_patient/dashboardScreen.dart';
import 'package:healthway_app/screens_patient/healthScreen.dart';
import 'package:healthway_app/screens_patient/notificationScreen.dart';
import 'package:healthway_app/screens_patient/profileScreen.dart';
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
        '/signUp': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/chat': (context) => ChatScreen(),
        '/diet': (context) => DietManagementScreen(),
        '/alimentos': (context) => AlimentosScreen(),
        '/nutricionistas': (context) => NutricionistasScreen(),
        '/presentation': (context) => PresentationScreen(),
        '/profile': (context) => PatientProfileScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/progress': (context) => ProgressScreen(),
      },
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progresso')),
      body: Center(child: Text('Tela de Progresso')),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Center(child: Text('Tela de Chat')),
    );
  }
}
