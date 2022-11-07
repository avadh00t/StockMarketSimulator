import 'package:flutter/material.dart';
import 'package:stock_market_simulator/screens/DrawerPage/sideDrawer.dart';
import 'package:stock_market_simulator/services/apiCalls/api_calls.dart';
import 'package:stock_market_simulator/services/searchService/search_service.dart';
import 'package:stock_market_simulator/services/watchlistPortfolioProvider/watchlist_portfolio_provider.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {

  final Future<List<dynamic>> _watchlist = WatchListPortfolioProvider().fetchWatchList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        title: const Text('Watchlist'),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: MySearch());
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _watchlist,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          }
          if(snapshot.hasData) {
            List<dynamic> stocks = snapshot.data;
            return ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                if(stocks.isEmpty) {
                  return Center(child: Text('Please Add Stocks To WatchList'),);
                }
                return ListTile(
                  leading: Text('NSE'),
                  title: Text(stocks[index]['WatchList']),
                  trailing: FutureBuilder(
                    future: APICalls().fetchStockPrice(stocks[index]['Symbol']),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasError) {
                        return Text('EO');
                      }
                      if(snapshot.hasData) {
                        return Text(snapshot.data);
                      }
                      return CircularProgressIndicator();
                    }
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
