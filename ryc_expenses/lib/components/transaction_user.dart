import 'package:flutter/material.dart';
import 'package:ryc_expenses/components/transaction_form.dart';
import 'package:ryc_expenses/components/transaction_list.dart';
import 'package:ryc_expenses/models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
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
    return Column(
      children: <Widget>[
        TransactionList(_transactions),
        TransactionForm(),
      ],
    );
  }
}
