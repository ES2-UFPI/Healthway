import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_dashboard.dart';

void main() {
  testWidgets('NutritionistDashboardScreen displays correctly', (WidgetTester tester) async {
    // Build the NutritionistDashboardScreen widget.
    await tester.pumpWidget(MaterialApp(home: NutritionistDashboardScreen()));

    // Verify if the background color is correct.
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor, const Color(0xFFE6F7F8));

    // Verify if the AppBar widget is present.
    expect(find.byType(AppBar), findsOneWidget);

    // Verify if the Icon widget is present.
    expect(find.byType(Icon), findsOneWidget);

    // Verify if the Padding widget is present.
    expect(find.byType(Padding), findsOneWidget);

    // Verify if the Form widget is present.
    expect(find.byType(Form), findsOneWidget);

    // Verify if the TextFormField widget is present.
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verify if the ElevatedButton widget is present.
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify if the CircularProgressIndicator widget is present.
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Add more specific tests for the widgets inside the Column as needed.
  });

  testWidgets('NutritionistDashboardScreen displays CircularProgressIndicator when loading', (WidgetTester tester) async {
    // Build the NutritionistDashboardScreen widget.
    await tester.pumpWidget(MaterialApp(home: NutritionistDashboardScreen()));

    // Verify if the CircularProgressIndicator widget is present.
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Tap the ElevatedButton to simulate a loading state.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify if the CircularProgressIndicator widget is present.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });


}