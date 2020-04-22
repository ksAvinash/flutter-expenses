import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactionItem;
  TransactionList(this.transactions, this.deleteTransactionItem);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        child: (transactions.length == 0)
            ? Container(
                margin: const EdgeInsets.all(100),
                child: Image.asset('assets/images/add_transaction.png'),
              )
            : ListView(
                children: transactions.map((trx) {
                  return TransactionItem(ValueKey(trx.trxId) , trx, deleteTransactionItem);
                }).toList(),
              ),
      );
    });
  }
}
