import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DrawerPage/sideDrawer.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('Portfolio'),
      ),
    );
  }
}
