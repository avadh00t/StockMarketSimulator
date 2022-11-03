import 'package:http/http.dart' as http;
import 'dart:convert';

class APICalls {

  Future<List<Map>> fetchStockName() async {
    List<Map> stocks = [];
    http.Response response = await http.get(Uri.parse('https://api.twelvedata.com/stocks?exchange=nse'));
    if(response.statusCode == 200){
      String jsonString = response.body;
      List data = jsonDecode(jsonString)['data'];
      stocks = data.cast<Map>();
    }
    return stocks;
  }

  fetchStockPrice(String stockName) async {
    var stockPrice;
    http.Response response = await http.get(Uri.parse('https://api.twelvedata.com/price?symbol=$stockName&exchange=NSE&apikey=f32767965dbd48a9b080e3e6900891e9'));
    if(response.statusCode == 200) {
      String jsonString = response.body;
      var data = jsonDecode(jsonString);
      print(data);
      stockPrice = data;
      print(stockPrice);
    }
    return stockPrice;
  }

  //https://api.twelvedata.com/time_series?symbol=INFY&exchange=NSE&interval=1day&apikey=f32767965dbd48a9b080e3e6900891e9
  //https://api.twelvedata.com/price?symbol=${}&exchange=NSE&apikey=f32767965dbd48a9b080e3e6900891e9
}