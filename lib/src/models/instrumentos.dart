import 'package:list_view_filter/controllers/instrumento_controller.dart';

import '../../helpers/formatter.dart';
// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
class Instrumento {
  final String _ticker;
  final String _nome;
  final String _classe;
  final double _fechamento;
  final double _fechamentoAnterior;

  Instrumento(
      {required String ticker,
      required String nome,
      required String classe,
      required double fechamento,
      required double fechamentoAnterior})
      : _ticker = ticker,
        _nome = nome,
        _classe = classe,
        _fechamento = fechamento,
        _fechamentoAnterior = fechamentoAnterior;

  String get ticker => _ticker;
  String get nome => _nome;
  String get classe => _classe;
  String get fechamento => real.format(_fechamento);
  String get anterior => real.format(_fechamentoAnterior);
  String get variacao =>
      percentual.format(_fechamento / _fechamentoAnterior - 1);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'ticker': _ticker,
      'nome': _nome,
      'classe': _classe,
      'fechamento': {'atual': _fechamento, 'anterior': _fechamentoAnterior}
    };
    return json;
  }

  static Instrumento fromJson(String ticker, Map<String, dynamic> instrumentos,
      double ultimo, double penultimo) {
    try {
      // String ticker = instrumentos['ticker'];
      String classe = instrumentos['Classe'];
      String nome = classe == 'Opcao'
          ? instrumentos['Instrumento']
          : instrumentos['Nome'];
      double fechamento = ultimo;
      double anterior = penultimo;
      Instrumento i = Instrumento(
          ticker: ticker,
          nome: nome,
          classe: classe,
          fechamento: fechamento,
          fechamentoAnterior: anterior);
      return i;
    } catch (e) {
      // print(ticker);
      // print(e.toString());
      // return null;
      return Instrumento(
          ticker: 'noticker',
          nome: 'No Name',
          classe: 'No Class',
          fechamento: 0.0,
          fechamentoAnterior: 0.0);
    }
  }
}

List<Instrumento> instrumentos = InstrumentoController.instrumentos;

// List<Instrumento> instrumentos = [
//   Instrumento(
//       ticker: 'BBAS3',
//       nome: 'BANCO DO BRASIL',
//       classe: 'ACAO',
//       fechamento: 25.35,
//       fechamentoAnterior: 25.89),
//   Instrumento(
//       ticker: 'PETR4',
//       nome: 'PETROBRAS PN N1',
//       classe: 'ACAO',
//       fechamento: 34.35,
//       fechamentoAnterior: 33.42),
//   Instrumento(
//       ticker: 'BBDC4',
//       nome: 'BRADESCO PN',
//       classe: 'ACAO',
//       fechamento: 22.35,
//       fechamentoAnterior: 21.78),
//   Instrumento(
//       ticker: 'BBDCE221',
//       nome: 'BRADESCO PN',
//       classe: 'OPCAO',
//       fechamento: 0.46,
//       fechamentoAnterior: 0.59),
//   Instrumento(
//       ticker: 'BBDCE226',
//       nome: 'BRADESCO PN',
//       classe: 'OPCAO',
//       fechamento: 0.42,
//       fechamentoAnterior: 0.54),
//   Instrumento(
//       ticker: 'BBDCQ213',
//       nome: 'BRADESCO PN',
//       classe: 'OPCAO',
//       fechamento: 0.57,
//       fechamentoAnterior: 0.43),
//   Instrumento(
//       ticker: 'BBDCQ198',
//       nome: 'BRADESCO PN',
//       classe: 'OPCAO',
//       fechamento: 0.21,
//       fechamentoAnterior: 0.08),
//   Instrumento(
//       ticker: 'XPCA11',
//       nome: 'FUNDO FIAGRO CA',
//       classe: 'FUNDO',
//       fechamento: 10.09,
//       fechamentoAnterior: 10.22),
//   Instrumento(
//       ticker: 'CYRE3',
//       nome: 'CYRELA REALTON',
//       classe: 'ACAO',
//       fechamento: 15.49,
//       fechamentoAnterior: 15.12),
//   Instrumento(
//       ticker: 'CYREE170',
//       nome: 'CYRELA REALTON',
//       classe: 'OPCAO',
//       fechamento: 0.33,
//       fechamentoAnterior: 0.42),
//   Instrumento(
//       ticker: 'CYREQ140',
//       nome: 'CYRELA REALTON',
//       classe: 'OPCA0',
//       fechamento: 0.72,
//       fechamentoAnterior: 0.15),
// ];
