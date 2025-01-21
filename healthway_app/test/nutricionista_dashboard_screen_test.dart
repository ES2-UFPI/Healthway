import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/screens_nutricionist/meal_plan_screen.dart';
import 'package:healthway_app/screens_patient/patient_dashboard_screen.dart';
import 'package:healthway_app/screens_patient/patient_profile_screen.dart';

void main() {
  final Map<String, dynamic> mockUserData = <String, dynamic>{
    'nome': 'John Doe',
    'email': 'ho@gmail.com',
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
          case '/meal_plan':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => MealPlanScreen(patientData: args, isPatient: true),
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

    expect(find.text('Próxima consulta:'), findsOneWidget);
    expect(find.text('Nutricionista'), findsOneWidget);
    expect(find.text('Dr. João Silva'), findsOneWidget);
  });

  testWidgets('PatientProfileScreen displays user data correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PatientProfileScreen(userData: mockUserData),
    ));

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('01/01/2000'), findsOneWidget);
    expect(find.text('180 cm'), findsOneWidget);
    expect(find.text('75 kg'), findsOneWidget);
    expect(find.text('88 cm'), findsOneWidget);
    expect(find.text('6.5 kg'), findsOneWidget);
    expect(find.text('15.5%'), findsOneWidget);
    expect(find.text('Amendoim'), findsOneWidget);
    expect(find.text('Leite'), findsOneWidget);
    expect(find.text('Vegano'), findsOneWidget);
  });

  testWidgets('PatientProfileScreen navigates to edit profile on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/edit_profile':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PatientProfileScreen(userData: args),
            );
          default:
            return null;
        }
      },
      home: PatientProfileScreen(userData: mockUserData),
    ));

    await tester.tap(find.byKey(Key('edit_profile_button')));
    await tester.pumpAndSettle();

    expect(find.byType(PatientProfileScreen), findsNothing);
  });


}