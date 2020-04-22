import 'dart:io';

import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/add_transaction.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAppScaffold(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        buttonColor: Colors.orangeAccent,
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class MyAppScaffold extends StatefulWidget {
  @override
  _MyAppScaffoldState createState() => _MyAppScaffoldState();
}

class _MyAppScaffoldState extends State<MyAppScaffold> with WidgetsBindingObserver {
  List<Transaction> _transactions = [];
  bool _showChartState = false;

  void _addTransactionItem(
      {@required String trxId,
      @required String title,
      @required double amount,
      @required DateTime date}) {
    setState(() {
      _transactions.add(
          Transaction(trxId: trxId, amount: amount, title: title, date: date));
      Navigator.pop(context);
    });
  }

  void _deleteTransactionItem(String trxId) {
    int index = -1;
    for (int i = 0; i < _transactions.length; i += 1) {
      if (_transactions[i].trxId == trxId) {
        index = i;
        break;
      }
    }
    if (index > -1) {
      setState(() {
        _transactions.removeAt(index);
      });
    }
  }

  void _showAddNewTransactionCard(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return AddTransaction(_addTransactionItem);
        });
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('app lifecycle state changed to $state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    final _mediaQuery = MediaQuery.of(context);

    final PreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expense Planner'),
            trailing: CupertinoButton(
              child: const Icon(
                CupertinoIcons.add,
                color: Colors.black,
              ),
              onPressed: () => _showAddNewTransactionCard(context),
            ))
        : AppBar(
            title: Text('Expense Planner'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.note_add,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () => _showAddNewTransactionCard(context),
              ),
            ],
          );
    final _availableHeight = (_mediaQuery.size.height -
        _appBar.preferredSize.height -
        _mediaQuery.padding.top);
    final _isLandscapeMode = _mediaQuery.orientation == Orientation.landscape;

    final pageBody = SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_isLandscapeMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Show Chart'),
                Switch.adaptive(
                    value: _showChartState,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (val) {
                      setState(() {
                        _showChartState = val;
                      });
                    }),
              ],
            ),
          if (_isLandscapeMode)
            _showChartState
                ? Container(
                    height: _availableHeight * 0.75,
                    child: Chart(_transactions),
                  )
                : Container(
                    height: _availableHeight * 0.8,
                    child:
                        TransactionList(_transactions, _deleteTransactionItem),
                  ),
          if (!_isLandscapeMode)
            Container(
              height: _availableHeight * 0.225,
              child: Chart(_transactions),
            ),
          if (!_isLandscapeMode)
            Container(
              height: _availableHeight * 0.65,
              child: TransactionList(_transactions, _deleteTransactionItem),
            )
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: _appBar,
          )
        : Scaffold(
            appBar: _appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? null
                : FloatingActionButton(
                    child: Icon(
                      Icons.note_add,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () => _showAddNewTransactionCard(context),
                  ),
          );
  }
}
