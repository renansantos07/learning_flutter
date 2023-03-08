import 'package:flutter/material.dart';

void main() => runApp(PerguntaApp());

class PerguntaApp extends StatelessWidget {
  var perguntaSelecionada = 0;

  void responder() {
    perguntaSelecionada++;
    print(perguntaSelecionada);
  }

  @override
  Widget build(BuildContext context) {
    final perguntas = ['Qual sua cor favorita?', 'Qual seu animal favorito?'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Perguntas')),
        body: Column(
          children: <Widget>[
            Text(perguntas[perguntaSelecionada]),
            ElevatedButton(
                onPressed: responder, child: const Text('Resposta 1')),
            ElevatedButton(
                onPressed: responder, child: const Text('Resposta 2')),
            ElevatedButton(
                onPressed: responder, child: const Text('Resposta 3'))
          ],
        ),
      ),
    );
  }
}
