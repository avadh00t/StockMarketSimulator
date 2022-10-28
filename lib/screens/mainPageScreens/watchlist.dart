import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_simulator/screens/DrawerPage/sideDrawer.dart';

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
        title: Text('Watchlist'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.search_rounded),
          ),
        ],
      ),
    );
  }
}
