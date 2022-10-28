import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_simulator/screens/mainPageScreens/transactions.dart';
import 'package:stock_market_simulator/screens/mainPageScreens/watchlist.dart';

import '../../mainPageScreens/portfolio.dart';

class MainPageBackground extends StatefulWidget {
  const MainPageBackground({Key? key}) : super(key: key);

  @override
  State<MainPageBackground> createState() => _MainPageBackgroundState();
}

class _MainPageBackgroundState extends State<MainPageBackground> {

  int currentIndex = 0;
  final screens = [
    Watchlist(),
    Portfolio(),
    Transactions()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 00,
        selectedItemColor: const Color(0xffff3c0e),
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (index) => setState(()=> currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
            ),
            label: 'Watchlist',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Transactions',
          ),
        ],
      ),
    );
  }
}
