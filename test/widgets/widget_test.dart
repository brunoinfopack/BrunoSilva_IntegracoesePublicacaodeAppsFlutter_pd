// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_control_panel/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MainApp());

    // Verify that our counter starts at 0.
    expect(find.text('Acessar'), findsOneWidget);
    expect(find.text('Ainda não tenho cadastro!'), findsOneWidget);
    expect(find.text('Cadastrar'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.text('Ainda não tenho cadastro!'));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Acessar'), findsNothing);
    expect(find.text('Cadastrar'), findsOneWidget);
  });
}
