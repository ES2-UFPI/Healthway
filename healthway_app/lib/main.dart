import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:healthway_app/geral_screens/alimentos_screen.dart';
import 'package:healthway_app/geral_screens/chat_screen.dart';
import 'package:healthway_app/geral_screens/login_screen.dart';
import 'package:healthway_app/geral_screens/nutricionistas_screen.dart';
import 'package:healthway_app/geral_screens/presentation_screen.dart';
import 'package:healthway_app/screens_nutricionist/meal_plan_screen.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_dashboard_screen.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_profile.dart';
import 'package:healthway_app/screens_nutricionist/patient_list_screen.dart';
import 'package:healthway_app/screens_nutricionist/schedule_screen.dart';
import 'package:healthway_app/screens_nutricionist/signup_nutritionist_screen.dart';
import 'package:healthway_app/screens_patient/notificationScreen.dart';
import 'package:healthway_app/screens_patient/patient_dashboard_screen.dart';
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
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kPrimaryColor, // Define a cor do cursor
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.black,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kPrimaryColor, // Define a cor do cursor
        ),
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
        // '/historic': (context) => PlanoAlimentarScreen(
        //       pacienteId: '',
        //     ),
        '/alimentos': (context) => AlimentosScreen(),
        '/nutricionistas': (context) => NutricionistasScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/settings': (context) => SettingsScreen(),
        '/schedule': (context) => ScheduleScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home_patient':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PatientDashboardScreen(userData: args),
            );
          case '/home_nutritionist':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => NutritionistDashboardScreen(userData: args),
            );
          case '/patient_profile':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PatientProfileScreen(userData: args),
            );
          case '/nutritionist_profile':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => NutritionistProfileScreen(userData: args),
            );
          case '/meal_plan':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => MealPlanScreen(patientData: args),
            );
          case '/patient_list':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PacientesScreen(
                args: args,
              ),
            );
          default:
            return null;
        }
      },
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: kPrimaryColor,
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
