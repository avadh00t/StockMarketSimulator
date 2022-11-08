
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


}