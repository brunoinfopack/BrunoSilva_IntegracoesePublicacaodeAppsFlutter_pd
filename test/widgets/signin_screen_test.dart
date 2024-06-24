import 'package:auto_control_panel/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {

  testWidgets('description', (WidgetTester tester) async {
    await tester.pumpWidget(SigninScreen());

    final textFormFieldEmail =
        find.byKey(const Key('TextFormFieldSigninEmail'));
    final textFormFieldSenha =
        find.byKey(const Key('TextFormFieldSigninSenha'));
    final btnAcessar = find.text('Acessar');

    tester.enterText(textFormFieldEmail, "bruno@infopack.com.br");
    tester.enterText(textFormFieldSenha, "654321");
    tester.tap(btnAcessar);

    expect(textFormFieldEmail, findsOneWidget);
  });
}
