import 'package:flutter/material.dart';
import 'package:stock_market_simulator/services/apiCalls/api_calls.dart';

class MySearch extends SearchDelegate {

  final Future<List<Map>> _stockMap = APICalls().fetchStockName();
  final List<String> stockNames = [];
  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.close),
      onPressed: (){
        if(query.isEmpty) {
          close(context, null);
        }else {
          query ='';
        }
      },
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back_rounded),
    onPressed: (){
      close(context, null);
    },
  );

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
    // TODO: implement buildResults
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _stockMap,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('error occurred ${snapshot.error}'),);
        }
        if(snapshot.hasData) {
          List<dynamic> stocks = snapshot.data;
          for(int i=0; i<stocks.length; i++) {
            stockNames.add(stocks[i]['name']);
          }
          final suggestions = stockNames.where((stock) {
            final stockLower = stock.toLowerCase();
            final queryLower = query.toLowerCase();
            return stockLower.startsWith(queryLower);
          }).toList();
          return buildSuggestionsSuccess(suggestions);
        }
        return const Center(child: CircularProgressIndicator(),);
      }
    );
  }

  Widget buildSuggestionsSuccess (List<String> stockList) {
    return ListView.builder(
      itemCount: stockList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Text('NSE'),
            title: Text(stockList[index]),
            trailing: ElevatedButton(
              child: Text('Add'),
              onPressed: (){},
            ),
          ),
        );
      }
    );
  }

}