import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../services/watchlistPortfolioProvider/watchlist_portfolio_provider.dart';
import '../../DrawerPage/sideDrawer.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  final Future<List<dynamic>> _transactions = WatchListPortfolioProvider().fetchTransactions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder(
          future: _transactions,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()),);
            }
            if(snapshot.hasData) {
              List<dynamic> transactions = snapshot.data;
              return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Transaction type: ' + transactions[index]['Transaction']),
                      leading: Column(
                        children: [
                          Text('Stock name: ' + transactions[index]['Stock']),
                          Text('Quantity: ' + transactions[index]['Quantity'].toString()),
                          Text('Total Price: ' + transactions[index]['Total Price'].toString())
                        ],
                      ),
                    ),
                  );
                }
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}
