import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expense/chart.dart';
import 'package:personal_expense/new_expense.dart';
import 'package:personal_expense/transaction.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personal_expense/transaction_widget.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: "Roboto"
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Transaction> transactions = [
  ];
  List<Transaction> get recentTransactions {
    return transactions.where((element){
      return element.date.isAfter(DateTime.now().subtract(Duration(
        days: 7
      )));
    }).toList();
  }
  void _startNewTransactionAdd(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(addExpense),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
  void deleteTransaction(int id) {
    setState(() {
      transactions.removeWhere((element) {
        return element.id==id;
      });
    });
  }
  void addExpense(String title, double amount, DateTime dateTime) {
    setState(() {
      transactions.add(
          Transaction(transactions.length + 1, title, amount, dateTime));
      Fluttertoast.showToast(
          msg: "Expense Added!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 18);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Personal Expenses"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Chart(recentTransactions)
              ),
              TransactionItem(transactions,deleteTransaction)
            ],
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startNewTransactionAdd(context),
          child: Icon(Icons.add),
        )
      );
  }
}


