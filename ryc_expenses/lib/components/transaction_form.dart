import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final void Function(String, double) _addTransaction;

  TransactionForm(this._addTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _addTransaction(
                    _titleController.text,
                    double.tryParse(_valueController.text) ?? 0,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                  ),
                  child: const Text('Nova transação'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
