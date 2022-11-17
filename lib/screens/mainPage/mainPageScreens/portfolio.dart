import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_simulator/services/watchlistPortfolioProvider/watchlist_portfolio_provider.dart';

import '../../../services/apiCalls/api_calls.dart';
import '../../DrawerPage/sideDrawer.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {

  final Future<List<dynamic>> _portfolio = WatchListPortfolioProvider().fetchPortfolio();
  var price;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('Portfolio'),
      ),
      body: FutureBuilder(
        future: _portfolio,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          }
          if(snapshot.hasData) {
            List<dynamic> stocks = snapshot.data;
            return ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Text(stocks[index]['Portfolio']),
                    title: Column(
                      children: [
                        Text('Buying price: ' + stocks[index]['Price'].toString()),
                        FutureBuilder(
                            future: APICalls().fetchStockPrice(stocks[index]['Symbol']),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasError) {
                                return Text('EO');
                              }
                              if(snapshot.hasData) {
                                price = double.parse(snapshot.data);
                                return Text('CMP: ' + price.toString(),
                                );
                              }
                              return CircularProgressIndicator();
                            }
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      child: Text('Sell'),
                      onPressed: () {},
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
