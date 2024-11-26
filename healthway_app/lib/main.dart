<<<<<<< HEAD
<<<<<<< HEAD:app/lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Você pressionou o botão esta quantidade de vezes:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: Icon(Icons.add),
      ),
    );
  }
}
=======
=======
>>>>>>> 0748151f482761dc8cc74f5aa0f00ed53e519e01
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
<<<<<<< HEAD

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchMessage();
  }

  Future<void> fetchMessage() async {
    final apiUrl = const String.fromEnvironment('API_URL', defaultValue: 'http://localhost:3000/');
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          message = data['message'];
        });
      } else {
        setState(() {
          message = "Failed to load message";
        });
      }
    } catch (e) {
      setState(() {
        message = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter + Express API'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
>>>>>>> main:healthway_app/lib/main.dart
=======
>>>>>>> 0748151f482761dc8cc74f5aa0f00ed53e519e01
