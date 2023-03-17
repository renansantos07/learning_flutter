import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ryc_expenses/components/chart_bar.dart';
import 'package:ryc_expenses/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );

      double totalSum = 0.0;

      recentTransaction.forEach((element) {
        bool sameDay = element.date.day == weekDay.day;
        bool sameMonth = element.date.month == weekDay.month;
        bool sameYear = element.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += element.value;
        }
      });

      return {
        'day': DateFormat.E().format(weekDay)[0],
        "value": totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, element) {
      return sum + (element['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((elem) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: elem['day'] as String,
                value: elem['value'] as double,
                percent: _weekTotalValue == 0
                    ? 0
                    : (elem['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
