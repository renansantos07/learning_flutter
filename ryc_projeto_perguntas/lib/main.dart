import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

void main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;

  void _responder() {
    setState(() {
      _perguntaSelecionada++;
    });
    print(_perguntaSelecionada);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> perguntas = [
      {
        "texto": 'Qual sua cor favorita?',
        "respostas": ['Preto', 'Vermelho', 'Verde', 'Branco']
      },
      {
        "texto": 'Qual seu animal favorito?',
        "respostas": ['Coelho', 'Cobra', 'Elefante', 'Leão']
      },
      {
        "texto": 'Qual seu instrutor favorito?',
        "respostas": ['Maria', 'João', 'Leo', 'Pedro']
      },
    ];

    List<String> respostas =
        perguntas[_perguntaSelecionada].cast()['respostas'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Perguntas')),
        body: Column(children: <Widget>[
          Questao(perguntas[_perguntaSelecionada]['texto'].toString()),
          ...respostas.map((elem) => Resposta(elem, _responder))
        ]),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  @override
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}
