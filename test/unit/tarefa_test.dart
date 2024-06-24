import 'package:auto_control_panel/providers/auth_provider.dart';
import 'package:auto_control_panel/providers/tarefa_provider.dart';
import 'package:auto_control_panel/providers/weather_provider.dart';
import 'package:auto_control_panel/screens/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:projeto_tarefa_pk/projeto_tarefa_pk.dart';
import 'package:test/test.dart';

void main() {
  group('Testa a função concatenaDescricao', () {
    test('Deve retornar Descrição: Teste1 no concatena para Teste1', () {
      // A - Arrumação
      String descricao = 'Teste1';
      String respostaEsperada = 'Descrição: $descricao';
      Tarefa tarefa = Tarefa(descricao, DateTime.now(), '');
      // A - Ação
      String respostaEncontrada = tarefa.concatenaDescricao();

      // A - Averiguação
      expect(respostaEsperada, respostaEncontrada);
    });
    test('Deve retornar Descrição: Teste2 no concatena para Teste2', () {
      // A - Arrumação
      String descricao = 'Teste2';
      String respostaEsperada = 'Descrição: $descricao';
      Tarefa tarefa = Tarefa(descricao, DateTime.now(), '');
      // A - Ação
      String respostaEncontrada = tarefa.concatenaDescricao();

      // A - Averiguação
      expect(respostaEsperada, respostaEncontrada);
    });
  });

  group('Testa a função concatenaData', () {
    test(
        'Deve retornar Data: dataatual no concatena para nome = Data e Datetime.now',
        () {
      // A - Arrumação
      DateTime dtHora = DateTime.now();
      String respostaEsperada =
          'Data: ${DateFormat('dd/MM/yyyy HH:mm').format(dtHora)}';
      Tarefa tarefa = Tarefa('', dtHora, '');
      // A - Ação
      String respostaEncontrada = tarefa.concatenaData();

      // A - Averiguação
      expect(respostaEsperada, respostaEncontrada);
    });

    test(
        "Deve retornar Data: 20/06/2024 20:46 no concatena para nome = Data e DateTime.parse('2024-06-20 20:46:04Z');",
        () {
      // A - Arrumação
      DateTime dtHora = DateTime.parse('2024-06-20 20:46:04Z');
      String respostaEsperada =
          'Data: ${DateFormat('dd/MM/yyyy HH:mm').format(dtHora)}';
      Tarefa tarefa = Tarefa('', dtHora, '');
      // A - Ação
      String respostaEncontrada = tarefa.concatenaData();

      // A - Averiguação
      expect(respostaEsperada, respostaEncontrada);
    });
  });

  group('Testa a função concatenaGeolocalizacao', () {
    test(
        'Deve retornar Latitude Longitude geolocalizacao no concatena para -23.5079634 -47.4745328',
        () {
      // A - Arrumação
      String geolocalizacao = '-23.5079634 -47.4745328';
      String respostaEsperada = 'Latitude Longitude \n$geolocalizacao';
      Tarefa tarefa = Tarefa('', DateTime.now(), geolocalizacao);
      // A - Ação
      String respostaEncontrada = tarefa.concatenaGeolocalizacao();

      // A - Averiguação
      expect(respostaEsperada, respostaEncontrada);
    });

    test(
        'Deve retornar Latitude Longitude geolocalizacao no concatena para -26.5307451 -47.4662306',
        () {
      // A - Arrumação
      // A - Arrumação
      String geolocalizacao = '-26.5307451 -47.4662306';
      String respostaEsperada = 'Latitude Longitude \n$geolocalizacao';
      Tarefa tarefa = Tarefa('', DateTime.now(), geolocalizacao);
      // A - Ação
      String respostaEncontrada = tarefa.concatenaGeolocalizacao();

      // A - Averiguação
      expect(respostaEsperada, respostaEncontrada);
    });
  });
}
