import 'package:flutter/material.dart';
import 'package:healthway_app/screens/apresentaionScreen.dart';
import 'package:healthway_app/screens/dashboardScreen.dart';
import 'package:healthway_app/screens/healthScreen.dart';
import 'package:healthway_app/screens/loginScreen.dart';
import 'package:healthway_app/screens/notificationScreen.dart';
import 'package:healthway_app/screens/profileScreen.dart';
import 'package:healthway_app/screens/setingsScreen.dart';
import 'package:healthway_app/screens/signupScreen.dart';

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
        '/home': (context) => DashboardScreen(onThemeChanged: (bool value) {  },),
        '/signUp': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/chat': (context) => ChatScreen(),
        '/health': (context) => HealthScreen(),
        '/menu': (context) => MenuScreen(),
        '/presentation': (context) => PresentationScreen(),
        '/profile': (context) => ProfileScreen(),
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
