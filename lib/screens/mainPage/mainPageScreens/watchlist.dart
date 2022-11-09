import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var price;
  final quantityController = TextEditingController();

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
                return Card(
                  child: ListTile(
                    leading: Text('NSE'),
                    title: Column(
                      children: [
                        Text(stocks[index]['WatchList']),
                        FutureBuilder(
                            future: APICalls().fetchStockPrice(stocks[index]['Symbol']),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasError) {
                                return Text('EO');
                              }
                              if(snapshot.hasData) {
                                price = double.parse(snapshot.data);
                                return Text(price.toString());
                              }
                              return CircularProgressIndicator();
                            }
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      child: const Text('buy'),
                      onPressed: () {
                        showBottomSheet(

                          context: context,
                          builder: (builder) => Container(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 40),
                            color: const Color(0xffff533048),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Stock Name : ',
                                        style: TextStyle(
                                          fontSize: 20
                                        ),
                                      ),
                                      Text(
                                        stocks[index]['WatchList'],
                                        style: TextStyle(
                                          fontSize: 20
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Text(
                                        'Stock Price : ',
                                        style: TextStyle(
                                            fontSize: 20
                                        ),
                                      ),
                                      Text(
                                        price.toString(),
                                        style: TextStyle(
                                            fontSize: 20
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  TextField(
                                    controller: quantityController,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                                      filled: true,
                                      fillColor: Colors.yellow[50],
                                      hintText: ' Enter Quantity for eg.:- \"0\"',
                                      hintStyle: TextStyle(
                                        fontSize: 20
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  ElevatedButton(
                                    child: Text(
                                      'View Summery',
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    ),
                                    onPressed: (){
                                      var quantity = int.parse(quantityController.text);
                                      showBottomSheet(
                                        context: context,
                                        builder: (builder) => Container(
                                          padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 40),
                                          color: const Color(0xffff533048),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Center(
                                                child: Text(
                                                  'Order Summery',
                                                  style: TextStyle(
                                                    fontSize: 20
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Total Quantity : ',
                                                    style: TextStyle(
                                                      fontSize: 20
                                                    ),
                                                  ),
                                                  Text(
                                                    quantityController.text,
                                                    style: TextStyle(
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Total Price : ',
                                                    style: TextStyle(
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                  Text(
                                                    (price*quantity).toString(),
                                                    style: TextStyle(
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              ElevatedButton(
                                                child: Text('BUY'),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                ),
                                                onPressed: () async{
                                                  await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).add({
                                                    "Portfolio" : stocks[index]['WatchList'],
                                                    "Symbol" : stocks[index]['Symbol'],
                                                    "Price" : price,
                                                    "Quantity" : quantity,
                                                    "Total Price" : price*quantity
                                                  });

                                                  await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).add({
                                                    "Transaction" : "Buy",
                                                    "Stock" : stocks[index]['WatchList'],
                                                    "Quantity" : quantity,
                                                    "Total Price" : price*quantity,
                                                  });

                                                  var fundsFuture = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc('Funds').get();
                                                  var fundsData = fundsFuture.data();
                                                  print(fundsData);
                                                  var funds = fundsData!['Initial funds'];
                                                  print(funds.toString());
                                                  funds = funds-(price*quantity);
                                                  FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc('Funds').update({"Initial funds" : funds});
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(stocks[index]['Symbol'] + " Bought at " + price*quantity.toString())));
                                                  Navigator.pop(context);
                                                 },
                                              ),
                                            ],
                                          ),
                                        )
                                      );
                                    },
                                  ),
                                ],
                              ),
                          )
                        );
                      },
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
