import 'dart:math';

import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final Function addTransactionItem;
  AddTransaction(this.addTransactionItem);

  @override
  _AddTransactionState createState() {
    print('--->>\tcreateState()');
    return _AddTransactionState();
  }
}

class _AddTransactionState extends State<AddTransaction> {
  final _titleFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  Color _bgColor;

  void _submitNewTransaction() {
    if (_amountController.text.isNotEmpty &&
        _titleController.text.isNotEmpty &&
        _selectedDate != null) {
      if (double.parse(_amountController.text) > 0) {
        _amountFocusNode.unfocus();
        _titleFocusNode.unfocus();

        widget.addTransactionItem(
            trxId: DateTime.now().toString(),
            amount: double.parse(_amountController.text),
            title: _titleController.text,
            date: _selectedDate);
      }
    }
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      firstDate: DateTime(2020),
      lastDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    ).then((val) {
      if (val == null) return;
      setState(() {
        _selectedDate = val;
      });
    });
  }

  @override
  void initState() {
    // print('--->>\tinitState()');
    const availableColors = [
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

    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    print('bgColor $_bgColor');
    _selectedDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    super.initState();
  }

  @override
  void dispose() {
    // print('--->>\tdispose()');
    super.dispose();
  }

  @override
  void didUpdateWidget(AddTransaction oldWidget) {
    // print('--->>\tdidUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.only(bottom: _mediaQuery.viewInsets.bottom),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: TextField(
                  // textInputAction: TextInputAction.next,
                  focusNode: _titleFocusNode,
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) {
                    _titleFocusNode.unfocus();
                    _amountFocusNode.requestFocus();
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  focusNode: _amountFocusNode,
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) {
                    _amountFocusNode.unfocus();
                    _titleFocusNode.unfocus();
                    _showDatePicker(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _selectedDate == null
                          ? 'No Date selected'
                          : _selectedDate.toString(),
                    )),
                    FlatButton(
                        onPressed: () {
                          _amountFocusNode.unfocus();
                          _titleFocusNode.unfocus();
                          _showDatePicker(context);
                        },
                        child: const Text(
                          'Select Date',
                          style: TextStyle(color: Colors.deepOrange),
                        )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 30),
                margin: const EdgeInsets.symmetric(horizontal: 100),
                child: RaisedButton(
                    onPressed: _submitNewTransaction,
                    child: Text(
                      'Add Expense',
                      style: Theme.of(context).textTheme.button,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
