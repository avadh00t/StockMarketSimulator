
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WatchListPortfolioProvider {

  Future<List<dynamic>> fetchWatchList() async{
    List<dynamic> stocks = [];
    final response = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).orderBy('WatchList').get();
    for(var i in response.docs) {
      stocks.add(i.data());
    }
    print(stocks);
    return stocks;
  }

  Future<List<dynamic>> fetchPortfolio() async {
    List<dynamic> stocks = [];
    final response = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).orderBy("Portfolio").get();
    for(var i in response.docs) {
      stocks.add(i.data());
    }
    return stocks;
  }

  Future<List<dynamic>> fetchTransactions() async {
    List<dynamic> transactions = [];
    final response = await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).orderBy("Transaction").get();
    for(var i in response.docs) {
      transactions.add(i.data());
    }
    return transactions;
  }

}