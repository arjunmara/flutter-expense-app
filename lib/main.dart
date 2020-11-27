import './transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        amount: 20.99, date: DateTime.now(), id: 't1', title: 'New Shoes'),
    Transaction(
        amount: 35.99, date: DateTime.now(), id: 't2', title: 'New Phone'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Container(
                child: Text('chart'),
                color: Colors.blue,
              ),
              elevation: 5,
            ),
          ),
          Column(
            children: transactions.map((transaction) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.purple,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '\$${transaction.amount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transaction.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          transaction.date.toString().substring(0, 10),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
