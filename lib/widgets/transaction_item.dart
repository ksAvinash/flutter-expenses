import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransactionItem;
  Color _bgColor;
  final Key key;

  TransactionItem(this.key, this.transaction, this.deleteTransactionItem);
  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  void initState() {
    final availableColors = [
      Colors.pink,
      Colors.pinkAccent,
      Colors.red,
      Colors.redAccent,
      Colors.orange,
      Colors.orangeAccent,
      Colors.amber,
      Colors.amberAccent,
      Colors.lightBlue,
      Colors.lightGreenAccent,
    ];
    widget._bgColor = availableColors[Random().nextInt(availableColors.length)];
    print('initState called _bgColor: ${widget._bgColor}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            '${widget.transaction.amount}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          radius: 35,
          backgroundColor: widget._bgColor,
        ),
        title: Text(widget.transaction.title),
        subtitle: Text(widget.transaction.date.toString()),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () =>
              widget.deleteTransactionItem(widget.transaction.trxId),
        ),
      ),
    );
  }
}
