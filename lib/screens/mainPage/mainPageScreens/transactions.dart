import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../DrawerPage/sideDrawer.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('Transactions'),
      ),
    );
  }
}
