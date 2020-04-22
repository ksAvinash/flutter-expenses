import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount, percent;
  const ChartBar(this.amount, this.percent, this.day);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, contraints) {
      final height = contraints.maxHeight;
      return Column(
        children: <Widget>[
          SizedBox(height: height * 0.05),
          Container(height: height * 0.1, child: FittedBox(child: Text('$amount'))),
          SizedBox(height: height * 0.05),
          Stack(
            children: <Widget>[
              
              Container(
                width: 18,
                height: height * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black26),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              Container(
                width: 18,
                height: height * 0.6 * percent,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black26),
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.05),
          Container(height: height * 0.1, child: FittedBox(child: Text(day))),
          SizedBox(height: height * 0.05),
        ],
      );
    });
  }
}
