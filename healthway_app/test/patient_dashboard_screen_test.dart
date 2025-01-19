import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/screens_patient/patient_dashboard_screen.dart';

void main() {
  final Map<String, dynamic> mockUserData = {
    'nome': 'John Doe',
    'altura': 180,
    'peso': 75,
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

  testWidgets('PatientDashboardScreen navigates to meal plan on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PatientDashboardScreen(userData: mockUserData),
    ));

    await tester.tap(find.text('Dieta'));
    await tester.pumpAndSettle();

    expect(find.byType(PatientDashboardScreen), findsNothing);
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

  testWidgets('PatientDashboardScreen bottom navigation works',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PatientDashboardScreen(userData: mockUserData),
    ));

    await tester.tap(find.text('Dieta'));
    await tester.pumpAndSettle();
    expect(find.byType(PatientDashboardScreen), findsNothing);

    await tester.tap(find.text('Progresso'));
    await tester.pumpAndSettle();
    expect(find.byType(PatientDashboardScreen), findsNothing);

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();
    expect(find.byType(PatientDashboardScreen), findsNothing);
  });
}
