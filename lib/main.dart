import 'package:flutter/material.dart';
import 'package:list_view_filter/controllers/instrumento_controller.dart';
import 'package:list_view_filter/src/widgets/card_widget.dart';
import 'src/models/instrumentos.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Filtro ListView'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  List<Instrumento> allInstrumentos = InstrumentoController.instrumentos;
  bool selecionado = false;
  bool digitando = false;

  @override
  void initState() {
    super.initState();
    InstrumentoController.initInstrumentos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: controller,
                onChanged: buscaInstrumento,
                onTap: () {
                  selecionado = false;
                },
                decoration: InputDecoration(
                  prefixIcon: !selecionado ? const Icon(Icons.search) : null,
                  hintText: 'Procurar',
                  labelText: 'Instrumento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allInstrumentos.length,
                itemBuilder: (BuildContext context, int index) {
                  final instrumento = allInstrumentos[index];
                  return CardInstrumentPosition(instrumento: instrumento);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buscaInstrumento(String query) {
    final sugestoes = instrumentos.where((Instrumento instrumento) {
      final nome = instrumento.nome.toLowerCase();
      final ticker = instrumento.ticker.toLowerCase();
      final input = query.toLowerCase();
      if (query.isEmpty) {
        return ticker.isNotEmpty;
      }
      return nome.contains(input) || ticker.contains(input);
    }).toList();

    setState(() {
      allInstrumentos = sugestoes;
      selecionado = true;
    });
  }
}
