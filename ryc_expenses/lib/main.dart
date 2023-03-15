import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ryc_expenses/models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  MyHome({super.key});

  final List<Transaction> _transactions = [
    Transaction(
      id: "t1",
      title: "title 1",
      value: 23.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "title 2",
      value: 50.90,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Despesas Pessoais"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: const Card(
              color: Colors.amber,
              elevation: 5,
              child: Text("Grafico"),
            ),
          ),
          Column(
            children: _transactions.map((elem) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black,
                        width: 2,
                      )),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        elem.value.toString(),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(elem.title),
                        Text(
                          elem.date.toString(),
                        )
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
