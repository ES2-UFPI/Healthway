import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/constants.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_profile.dart';

void main() {
  final Map<String, dynamic> mockUserData = {
    'nome': 'Dr. Silva',
    'pacientes': ['João', 'Maria'],
  };
  testWidgets('NutritionistProfileScreen displays correctly',
      (WidgetTester tester) async {
    // Build the NutritionistProfileScreen widget.
    await tester.pumpWidget(
      MaterialApp(
        home: NutritionistProfileScreen(userData: mockUserData),
      ),
    );

    // Verify if the AppBar widget is present.
    expect(find.byType(AppBar), findsOneWidget);

    // Verify if the Scaffold widget has the correct background color.
    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.backgroundColor,
        kBackgroundColor); // Substitua com a cor definida por `kBackgroundColor`.

    // Verify if the CircleAvatar widget is present.
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Verify if the Form widget is present.
    expect(find.byType(Form), findsOneWidget);

    // Verify if the TextFormField widgets are present when editing.
    await tester
        .tap(find.byIcon(Icons.edit)); // Tap the edit button to enable editing.
    await tester.pump();
    expect(find.byType(TextFormField),
        findsNWidgets(5)); // Nome, email, CPF, CRN, Especialidade.

    // Verify if the ElevatedButton widget is present.
    expect(find.widgetWithText(ElevatedButton, 'Editar Perfil Detalhado'),
        findsOneWidget);

    // Verify if the OutlinedButton widget is present.
    expect(
        find.widgetWithText(OutlinedButton, 'Alterar Senha'), findsOneWidget);

    // Verify if the document image container is present.
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('Toggling edit mode in NutritionistProfileScreen',
      (WidgetTester tester) async {
    // Build the NutritionistProfileScreen widget.
    await tester.pumpWidget(
      MaterialApp(
        home: NutritionistProfileScreen(userData: {}),
      ),
    );

    // Initial state: not editing.
    expect(find.byType(TextFormField), findsNothing);

    // Tap the edit button to enable editing.
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();

    // Verify if TextFormFields appear for editing.
    expect(find.byType(TextFormField), findsWidgets);

    // Tap the close button to disable editing.
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    // Verify if TextFormFields disappear.
    expect(find.byType(TextFormField), findsNothing);
  });
}
