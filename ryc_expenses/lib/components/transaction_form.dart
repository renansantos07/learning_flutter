import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) _addTransaction;

  TransactionForm(this._addTransaction);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  onSubmit() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget._addTransaction(title, value);
  }

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
              onSubmitted: (_) => onSubmit(),
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              onSubmitted: (_) => onSubmit(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => onSubmit(),
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
