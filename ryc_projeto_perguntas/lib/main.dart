import 'package:flutter/material.dart';

void main() => runApp(PerguntaApp());

class PerguntaAppState extends State<PerguntaApp> {
  var perguntaSelecionada = 0;

  void responder() {
    setState(() {
      perguntaSelecionada++;
    });
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

class PerguntaApp extends StatefulWidget {
  PerguntaAppState createState() {
    return PerguntaAppState();
  }
}
