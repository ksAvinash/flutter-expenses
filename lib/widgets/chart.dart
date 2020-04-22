import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transaction;

  const Chart(this.transaction);


  List<Widget> get weeklyChartBars {
    final List<Widget> chartBars = [];
    double totalWeeklyExpense = 0;
    List<double> weeklyExpenses = [];

    // get the expenses for the last 7 days
    for (int day = 0; day < 7; day += 1) {
      weeklyExpenses.add(0.0);
      final weekDay = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: day));
      bool expenseFoundForDay = false;

      for (int i = 0; i < transaction.length; i += 1) {
        if (transaction[i].date.toString() == weekDay.toString()) {
          totalWeeklyExpense += transaction[i].amount;
          expenseFoundForDay = true;
          weeklyExpenses[day] = weeklyExpenses[day] + transaction[i].amount;
        }
      }

      if (!expenseFoundForDay) {
        weeklyExpenses[day] = 0.0;
      }
    }
    weeklyExpenses = weeklyExpenses.reversed.toList();

    for (int i = 0; i < weeklyExpenses.length; i += 1) {
      final weekDay = DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: i));
      chartBars.add(
        ChartBar(
          weeklyExpenses[i],
          totalWeeklyExpense > 0 ? weeklyExpenses[i] / totalWeeklyExpense : 0.0,
          DateFormat.E().format(weekDay),
        ),
      );
    }

    return chartBars;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: weeklyChartBars,
      ),
    );
  }
}
