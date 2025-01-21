import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/screens_patient/patient_dashboard_screen.dart';

void main() {
  final Map<String, dynamic> mockUserData = {
    'nome': 'John Doe',
    'email': 'exemplo@email.com',
    'dt_nascimento': '01/01/2000',
    'altura': 180,
    'peso': 75,
    'circunferencia_abdominal': 88,
    'massa_muscular': 6.5,
    'gordura_corporal': 15.5,
    'alergias': ['Amendoim', 'Leite'],
    'preferencias': ['Vegano'],
  };

  testWidgets('PatientDashboardScreen displays user data correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PatientDashboardScreen(userData: mockUserData),
    ));

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Vamos cuidar da sua saúde hoje!'), findsOneWidget);
    expect(find.text('IMC'), findsOneWidget);
    expect(find.text('Peso'), findsOneWidget);
    expect(find.text('Altura'), findsOneWidget);
  });

  testWidgets('PatientDashboardScreen displays next appointment',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PatientDashboardScreen(userData: mockUserData),
    ));

    expect(find.text('Próxima Consulta'), findsOneWidget);
    expect(find.text('Dr. Silva - Nutricionista'), findsOneWidget);
    expect(find.text('15 Mai\n14:00'), findsOneWidget);
  });

  testWidgets('PatientDashboardScreen displays daily progress',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PatientDashboardScreen(userData: mockUserData),
    ));

    expect(find.text('Progresso Diário'), findsOneWidget);
    expect(find.text('Calorias'), findsOneWidget);
    expect(find.text('Água'), findsOneWidget);
    expect(find.text('Passos'), findsOneWidget);
  });
}
