import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/constants.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_dashboard_screen.dart';

void main() {
  group('NutritionistDashboardScreen', () {
    testWidgets('Exibe o cabeçalho corretamente com o nome do usuário', (WidgetTester tester) async {
      // Dados simulados para o teste
      const String mockUserName = 'Teste Nutricionista';

      // Renderiza o widget com dados de teste
      await tester.pumpWidget(
        MaterialApp(
          home: NutritionistDashboardScreen(userData: {'name': mockUserName}),
        ),
      );

      // Verifica se o texto esperado está presente
      expect(find.text('Olá, Nutricionista!'), findsOneWidget);
      expect(find.text(mockUserName), findsOneWidget);
    });

    testWidgets('Não exibe widgets desnecessários ou duplicados', (WidgetTester tester) async {
      const String mockUserName = 'Nutricionista Exemplo';

      await tester.pumpWidget(
        MaterialApp(
          home: NutritionistDashboardScreen(userData: {'name': mockUserName}),
        ),
      );

      // Verifica que apenas um widget com "Olá, Nutricionista!" existe
      expect(find.text('Olá, Nutricionista!'), findsOneWidget);

      // Certifica-se de que widgets com textos incorretos não existem
      expect(find.text('Texto não esperado'), findsNothing);
    });
  });
}
