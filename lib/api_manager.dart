import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/SourceResponse.dart';

class ApiManager {
  static const String basicUrl = 'newsapi.org';

  ///https://newsapi.org/v2/top-headlines/sources?apiKey=3cc56814e8d24aefab84c8d718123a18
  ///
  static Future<SourceResponse> getData() async {
    Uri url = Uri.https(basicUrl, '/v2/top-headlines/sources',
        {'apiKey': '3cc56814e8d24aefab84c8d718123a18'});

    try {
      var response = await http.get(url);
      var bodyResponse = response.body;
      var json = jsonDecode(bodyResponse);
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
