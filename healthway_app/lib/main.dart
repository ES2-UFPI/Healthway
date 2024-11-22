import 'package:flutter/material.dart';
import 'screens/dashboardScreen.dart';
import 'screens/sleepAnalysisCard.dart';
import 'screens/selfLoveScreen.dart';
import 'screens/caloriesConsumedScreen.dart';
import 'screens/heartRateScreen.dart';
import 'screens/caloriesBurnedScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/sleepAnalysis': (context) => SleepAnalysisScreen(),
        '/selfLove': (context) => SelfLoveScreen(),
        '/caloriesConsumed': (context) => CaloriesConsumedScreen(),
        '/heartRate': (context) => HeartRateScreen(),
        '/caloriesBurned': (context) => CaloriesBurnedScreen(),
      },
    );
  }
}


