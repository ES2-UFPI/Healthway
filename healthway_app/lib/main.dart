import 'package:flutter/material.dart';
import 'package:healthway_app/screens/apresentaionScreen.dart';
import 'screens/dashboardScreen.dart';
import 'screens/sleepAnalysisCard.dart';
import 'screens/selfLoveScreen.dart';
import 'screens/caloriesConsumedScreen.dart';
import 'screens/heartRateScreen.dart';
import 'screens/caloriesBurnedScreen.dart';

void main() => runApp(const MyApp());

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
      themeMode: ThemeMode.system, // Alterna automaticamente entre claro e escuro
      initialRoute: '/',
      routes: {
        '/': (context) => PresentationScreen(),
        '/sleepAnalysis': (context) => const SleepCalculatorScreen(),
        '/selfLove': (context) => SelfLoveScreen(),
        '/caloriesConsumed': (context) => CaloriesConsumedScreen(),
        '/heartRate': (context) => HeartRateScreen(),
        '/caloriesBurned': (context) => CaloriesBurnedScreen(),
      },
    );
  }
}
