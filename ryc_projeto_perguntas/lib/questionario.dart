import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) responder;
  final bool temPerguntaSelecionada;

  const Questionario({
    required this.perguntas,
    required this.perguntaSelecionada,
    required this.responder,
    required this.temPerguntaSelecionada,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntas[perguntaSelecionada].cast()['respostas']
            as List<Map<String, Object>>
        : [];

    return Column(children: <Widget>[
      Questao(perguntas[perguntaSelecionada]['texto'].toString()),
      ...respostas.map((elem) => Resposta(
            elem['texto'] as String,
            () => responder(int.parse(elem['pontuacao'].toString())),
          ))
    ]);
  }
}
