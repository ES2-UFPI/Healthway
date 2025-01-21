import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healthway_app/screens_nutricionist/nutritionist_dashboard_screen.dart';

void main() {
  group('NutritionistDashboardScreen', () {
    testWidgets('Exibe o cabeçalho corretamente com o nome do usuário',
        (WidgetTester tester) async {
      // Dados simulados para o teste
      const String mockUserName = 'Teste Nutricionista';
      const List<String> mockPatients = ['Paciente 1', 'Paciente 2'];

      // Renderiza o widget com dados de teste
      await tester.pumpWidget(
        MaterialApp(
          home: NutritionistDashboardScreen(
              userData: {'nome': mockUserName, 'pacientes': mockPatients}),
        ),
      );

      // Verifica se o texto esperado está presente
      expect(find.text('Bem-vindo de volta'), findsOneWidget);
      expect(find.text(mockUserName), findsOneWidget);
    });

    testWidgets('Não exibe widgets desnecessários ou duplicados',
        (WidgetTester tester) async {
      const String mockUserName = 'Nutricionista Exemplo';
      const List<String> mockPatients = ['Paciente 1', 'Paciente 2'];

      await tester.pumpWidget(
        MaterialApp(
          home: NutritionistDashboardScreen(
              userData: {'nome': mockUserName, 'pacientes': mockPatients}),
        ),
      );

      // Verifica que apenas um widget com "Olá, Nutricionista!" existe
      expect(find.text('Bem-vindo de volta'), findsOneWidget);

      // Certifica-se de que widgets com textos incorretos não existem
      expect(find.text('Texto não esperado'), findsNothing);
    });
  });
}
