import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quotes_app_unit_2/models/quote_api_model.dart';

class QuotesRepository {
  // Get a random quotes
  Future<List<QuoteApi>> getRandomQuotes() async {
    String url = "https://api.quotable.io";
    String endpoint = "/quotes/random?limit=20";

    // send request to API
    final response = await http.get(Uri.parse(url + endpoint));

    // check if response is successful
    if (response.statusCode == 200) {
      final dataJson = jsonDecode(response.body);
      print(dataJson);
    }

    return [];
  }
}
