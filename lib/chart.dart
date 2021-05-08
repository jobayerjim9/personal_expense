import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/transaction.dart';
import 'package:personal_expense/transaction_widget.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }
      return {"day": DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(8),
      child: Row(
        children: groupedTransactionValues.map((e) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                e["day"],
                e["amount"],
                totalSpending == 0.0
                    ? 0.0
                    : (e["amount"] as double) / totalSpending),
          );
        }).toList(),
      ),
    );
  }
}

class ChartBar extends StatelessWidget {
  final String label;
  final double spending, spendingPct;

  ChartBar(this.label, this.spending, this.spendingPct);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
              height: 20,
              child: FittedBox(child: Text("\$" + spending.toString()))),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPct,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(label)
        ],
      ),
    );
  }
}
