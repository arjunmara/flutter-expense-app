import 'package:flutter/material.dart';

import './transactionItem.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.length > 0 ? ListView.builder(
        itemBuilder: (cxt, index) {
          return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
        },
        itemCount: transactions.length,
      ):
      LayoutBuilder(builder: (ctx, constraints){
        return Column(
        children : <Widget>[
          Text('No Transactions added yet!', style: Theme.of(context).textTheme.headline6,),
          SizedBox(height: 20,),
          Container(height: constraints.maxHeight*0.6, child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)),
        ]
      );
      }) 
      
    );
  }
}
