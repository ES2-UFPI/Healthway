import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/screens_patient/patient_dashboard_screen.dart';

void main() {
  testWidgets('PatientDashboardScreen displays correctly',
      (WidgetTester tester) async {
    // Build the PatientDashboardScreen widget.
    await tester.pumpWidget(MaterialApp(home: PatientDashboardScreen()));

    // Verify if the background color is correct.
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, const Color(0xFFF5F5F5));

    // Verify if the SafeArea widget is present.
    expect(find.byType(SafeArea), findsOneWidget);

    // Verify if the SingleChildScrollView widget is present.
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    // Verify if the Column widget is present.
    //expect(find.byType(Column), findsOneWidget);

    // Add more specific tests for the widgets inside the Column as needed.
  });
}
