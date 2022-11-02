import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_simulator/screens/DrawerPage/sideDrawer.dart';
import 'package:stock_market_simulator/services/apiCalls/api_calls.dart';
import 'package:stock_market_simulator/services/searchService/search_service.dart';
class Watchlist extends StatefulWidget {
  const Watchlist({Key? key}) : super(key: key);

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
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
    );
  }
}
