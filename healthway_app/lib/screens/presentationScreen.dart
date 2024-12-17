import 'package:flutter/material.dart';
import 'dart:async';

import 'package:healthway_app/screens/dashboardScreen.dart';
// import 'package:healthway_app/screens/loginScreen.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Configurando a animação
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // Navegar para a próxima tela após a animação
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => DashboardScreen(
                  onThemeChanged: (bool value) {},
                )),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF31BAC2),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'lib/assets/logo.png', // Substitua pelo caminho da sua logo
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
