import 'dart:io';

import 'package:flutter/material.dart';

import './widgets/newTransaction.dart';
import './widgets/transactionList.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
// WidgetsFlutterBinding.ensureInitialized();
// SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand', 
        textTheme: ThemeData.light().textTheme.copyWith(headline6: TextStyle(fontFamily: 'OpenSans'),button: TextStyle(color: Colors.white)),
        accentColor: Colors.amber
      ),
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [];
  bool _showChart = false;
  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    },).toList();
  }
  

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
        title: Text('Expense Tracker'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context))
        ],
      );
      final txWidget = Container(
        height: (mediaQuery.size.height -
         appBar.preferredSize.height - 
         mediaQuery.padding.top)*0.7,
         child: 
         TransactionList(_userTransactions, _deleteTransaction
         ));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text('Show Chart'),
                Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: _showChart, onChanged: (val){
                  setState(() {
                    _showChart = val;
                  });
                })
              ],
            ),
            if(!isLandScape) Container(height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.3, child: Chart(_recentTransactions)),
            if(!isLandScape) txWidget,
            if(isLandScape) _showChart ? 
            Container(height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.3, child: Chart(_recentTransactions))
            :
            txWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {_startAddNewTransaction(context)},
      ),
    );
  }
}
