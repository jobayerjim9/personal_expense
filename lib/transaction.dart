import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Transaction {
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(this.id, this.title, this.amount, this.date);
}
