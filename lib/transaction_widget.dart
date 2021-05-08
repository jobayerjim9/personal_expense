import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/transaction.dart';

class TransactionItem extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;


  TransactionItem(this.transactions, this.delete);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Container(
              height: 400,
              child: Image.asset(
                "assets/images/no_item.png",
                fit: BoxFit.cover,
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return ListTileCustom(transactions[index],delete);
              },
              itemCount: transactions.length,
            ),
    );
  }
}

class ListTileCustom extends StatelessWidget {
  Transaction transaction;
  final Function delete;
  ListTileCustom(this.transaction, this.delete);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: EdgeInsets.all(8),
              child:
                  FittedBox(child: Text("'\$" + transaction.amount.toString()))),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: IconButton(icon: Icon(Icons.delete),color: Theme.of(context).primaryColor,onPressed: () => delete(transaction.id) ,),
      ),
    );
  }
}

class TransactionsList extends StatelessWidget {
  Transaction transaction;

  TransactionsList(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Card(
        elevation: 8,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1)),
              padding: EdgeInsets.all(12.0),
              child: Text(
                "\$ " + transaction.amount.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    transaction.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  padding: EdgeInsets.fromLTRB(12, 4, 4, 2),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(12, 2, 4, 4),
                  child: Text(
                    transaction.date.day.toString() +
                        "-" +
                        transaction.date.month.toString() +
                        "-" +
                        transaction.date.year.toString(),
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
