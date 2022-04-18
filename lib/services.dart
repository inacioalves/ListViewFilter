// import 'package:http/http.dart' as http;
// import 'src/models/instrumentos.dart';

class Services {
  static const String fileInstrumentos = 'instrumentos.json';
  static const String fileCotacoes = 'cotacoes.json';

  static const String urlInstrumentos =
      'https://raw.githubusercontent.com/inacioalves/instrumentos/main/$fileInstrumentos';

  static const String urlCotacoes =
      'https://raw.githubusercontent.com/inacioalves/instrumentos/main/$fileCotacoes';
}
