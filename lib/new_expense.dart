import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addExpense;

  NewTransaction(this.addExpense);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  var titleController = TextEditingController();

  var amountController = TextEditingController();

  double amount;

  String title = "";
  DateTime selectedDateTime;
  void submitData() {
    if (title.isEmpty || amount == null || selectedDateTime==null) {
      Fluttertoast.showToast(
          msg: "Enter Details!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 18);
    } else {
      widget.addExpense(title, amount,selectedDateTime);
      Navigator.of(context).pop();
    }
  }

  void showPicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime.now(),
    ).then((value) {
      if(value==null) {
        return;
      }
      setState(() {
        selectedDateTime=value;
      });


    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Card(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: titleController,
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Enter Title",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8, top: 8),
                child: TextField(
                  controller: amountController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      amount = double.parse(value);
                    } else {
                      amount = null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Enter Amount",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDateTime==null ? "No Date Chosen!" : DateFormat.yMMMd().format(selectedDateTime),
                      style: TextStyle(fontSize: 16),
                    ),
                    MaterialButton(
                      child: Text("Choose Date!"),
                      textColor: Colors.white,
                      onPressed: showPicker,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: submitData,
                child: Text(
                  "Add Expense",
                  style: TextStyle(fontSize: 16),
                ),
                textColor: Colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
