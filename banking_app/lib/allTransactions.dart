import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AllTransactions extends StatefulWidget {
  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  List<Map> transactions;
  bool loading = true;

  void getTransactions() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'banking.db';
    var database = await openDatabase(
      path,
      version: 1,
    );

    transactions = await database.rawQuery('SELECT * FROM Transactions');
    setState(() {
      loading =false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All transactions'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (builder, index) {
                  var tr = transactions[index];
                  return Text(tr['Sender']);
                },
              ),
            ),
    );
  }
}
