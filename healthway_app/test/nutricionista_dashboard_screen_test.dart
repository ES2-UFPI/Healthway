import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_dashboard_screen.dart';

void main() {
  testWidgets('NutritionistDashboardScreen displays user data correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NutritionistDashboardScreen(userData: {},),
    ));

    expect(find.text('Olá, Nutricionista!'), findsOneWidget);
    expect(find.text('Vamos cuidar da saúde dos seus pacientes hoje!'),
        findsOneWidget);
    expect(find.text('Pacientes'), findsOneWidget);
    expect(find.text('Chat'), findsOneWidget);
  });

  testWidgets('NutritionistDashboardScreen navigates to chat on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/chat_nutricionist':
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(title: Text('Chat')),
              ),
            );
          default:
            return null;
        }
      },
      home: NutritionistDashboardScreen(userData: {},),
    ));

    await tester.tap(find.byKey(Key('dashboard_chat')));
    await tester.pumpAndSettle();

    expect(find.byType(NutritionistDashboardScreen), findsNothing);
  });
}