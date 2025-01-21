import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/constants.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_dashboard_screen.dart';

void main() {
  final Map<String, dynamic> mockUserData = {
    'nome': 'Dr. Silva',
    'pacientes': ['João', 'Maria'],
  };
  testWidgets('NutritionistDashboardScreen displays correctly',
      (WidgetTester tester) async {
    // Build the NutritionistDashboardScreen widget.
    await tester.pumpWidget(MaterialApp(
        home: NutritionistDashboardScreen(
      userData: mockUserData,
    )));

    // Verify if the background color is correct.
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, kBackgroundColor);

    // Verify if the Icon widget is present.
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
