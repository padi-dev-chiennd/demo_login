import 'dart:convert';

import 'package:http/http.dart' as http;
const apiKey = 'your Api key';
const url = 'https://rest.coinapi.io/v1/exchangerate/BTC/EUR?apikey=EEC8C305-A172-4709-8EE0-9F8239BF7CE7';
class Currency {
  Future<dynamic> getRate() async {

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {

      /// interprets a given string as JSON
      var decodedData = jsonDecode(response.body);
      var rate = decodedData['rate'];
      return rate;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}