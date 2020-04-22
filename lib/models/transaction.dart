import 'package:flutter/material.dart';

class Transaction {
  final String trxId, title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.trxId,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
