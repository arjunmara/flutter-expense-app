import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/chartBar.dart';
import '../models/transaction.dart';
class Chart extends StatelessWidget {

  final List<Transaction> recentTrasactions;
  Chart(this.recentTrasactions);
  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for(var i = 0; i<recentTrasactions.length;i++){
        if(recentTrasactions[i].date.day==weekDay.day 
        && recentTrasactions[i].date.month==weekDay.month 
        &&recentTrasactions[i].date.year==weekDay.year ){
          totalSum += recentTrasactions[i].amount;
        }
      }
      return {'day':DateFormat.E().format(weekDay).substring(0,1), 'amount':totalSum,};
    }).reversed.toList();
  }
  double get maxSpendings {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: groupedTransactionValues.map((data)  {
          return Flexible(fit: FlexFit.tight, child: ChartBar(label: data['day'],spendingAmount: data['amount'], spendingPercentageOfTotal: maxSpendings==0? 0.0 : (data['amount'] as double)/maxSpendings,));
          }).toList(),),
      ),
    );
  }
}