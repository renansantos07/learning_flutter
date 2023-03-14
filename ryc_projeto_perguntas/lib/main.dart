import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

void main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  final List<Map<String, Object>> _perguntas = [
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

  void _responder() {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
      });
    }
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Perguntas')),
        body: temPerguntaSelecionada
            ? Questionario(
                perguntas: _perguntas,
                perguntaSelecionada: _perguntaSelecionada,
                responder: _responder,
                temPerguntaSelecionada: temPerguntaSelecionada,
              )
            : const Resultado(),
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
