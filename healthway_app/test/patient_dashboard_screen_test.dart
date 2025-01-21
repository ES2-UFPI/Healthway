import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/screens_nutricionist/meal_plan_screen.dart';
import 'package:healthway_app/screens_patient/patient_dashboard_screen.dart';
import 'package:healthway_app/screens_patient/patient_profile_screen.dart';

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

  testWidgets('PatientDashboardScreen navigates to meal plan on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/meal_plan_patient':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => MealPlanScreen(
                patientData: args,
                isPatient: true,
              ),
            );
          default:
            return null;
        }
      },
      home: PatientDashboardScreen(userData: mockUserData),
    ));

    await tester.tap(find.byKey(Key('dashboard_dieta')));
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/meal_plan_patient':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) =>
                  MealPlanScreen(patientData: args, isPatient: true),
            );
          case '/patient_profile':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PatientProfileScreen(userData: args),
            );
          default:
            return null;
        }
      },
      home: PatientDashboardScreen(userData: mockUserData),
    ));

    await tester.tap(find.byKey(Key('bottom_nav_inicio')));
    await tester.pumpAndSettle();
    expect(find.byType(PatientDashboardScreen), findsOneWidget);

    await tester.tap(find.byKey(Key('bottom_nav_dieta')));
    await tester.pumpAndSettle();
    expect(find.byType(MealPlanScreen), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('bottom_nav_perfil')));
    await tester.pumpAndSettle();
    expect(find.byType(PatientProfileScreen), findsOneWidget);
  });
}
