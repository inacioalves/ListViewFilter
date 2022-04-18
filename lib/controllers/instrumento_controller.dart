import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../src/models/instrumentos.dart';

class InstrumentoController {
  static List<Instrumento> instrumentos = [];
  static Map<String, dynamic> instrumentosMap = {};
  static Map<String, dynamic> ultimo = {};
  static Map<String, dynamic> penultimo = {};

  static init() {}

  static createInstruments() {
    Set setInstrumentos = instrumentosMap['Dados'].keys.toSet();
    Set setUltimo = ultimo['Dados'].keys.toSet();
    Set setPenultimo = penultimo['Dados'].keys.toSet();
    List listInstrumentos = setInstrumentos
        .intersection(setUltimo)
        .intersection(setPenultimo)
        .toList();
    for (String ticker in listInstrumentos) {
      Instrumento i = Instrumento.fromJson(
          ticker,
          instrumentosMap['Dados'][ticker],
          ultimo['Dados'][ticker],
          penultimo['Dados'][ticker]);

      instrumentos.add(i);
    }
  }

  static Future<void> initInstrumentos() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      // final Directory? directory = await getApplicationSupportDirectory();

      String instrumentosPath = '${directory.path}/instrumentos_.json';
      String ultimoPath = '${directory.path}/ultimo.json';
      String penultimoPath = '${directory.path}/penultimo.json';

      if (File(instrumentosPath).existsSync()) {
        final File iJson = File(instrumentosPath);
        var body = iJson.readAsStringSync();
        instrumentosMap = json.decode(body) as Map<String, dynamic>;
      } else {
        var instrumentosJson = await http.get(Uri.parse(urlInstrumentos));
        instrumentosMap =
            json.decode(instrumentosJson.body) as Map<String, dynamic>;
        final File iJson = File(instrumentosPath);
        await iJson.writeAsString(instrumentosJson.body.toString());
      }

      if (File(ultimoPath).existsSync()) {
        final File uJson = File(ultimoPath);
        var body = uJson.readAsStringSync();
        ultimo = json.decode(body) as Map<String, dynamic>;
      } else {
        var cotacoesJson = await http.get(Uri.parse(urlUltimo));
        ultimo = json.decode(cotacoesJson.body) as Map<String, dynamic>;
        final File cJson = File(ultimoPath);
        await cJson.writeAsString(cotacoesJson.body.toString());
      }

      if (File(penultimoPath).existsSync()) {
        final File pJson = File(penultimoPath);
        var body = pJson.readAsStringSync();
        ultimo = json.decode(body) as Map<String, dynamic>;
      } else {
        var cotacoesJson = await http.get(Uri.parse(urlPenultimo));
        penultimo = json.decode(cotacoesJson.body) as Map<String, dynamic>;
        final File pJson = File(ultimoPath);
        await pJson.writeAsString(cotacoesJson.body.toString());
      }

      createInstruments();
    } catch (e) {
      print(e.toString());
      print("Couldn't read file");
    }
    throw (e) {
      print(e.toString());
    };
  }
}
