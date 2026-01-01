import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String BASE_URL = "https://agri-price-api-1.onrender.com";

  static const Map<String, String> _headers = {
    "Content-Type": "application/json",
    "ngrok-skip-browser-warning": "true",
  };



  static Future<List<String>> getStates() async {
    final res = await http.get(
      Uri.parse("$BASE_URL/dropdown/states"),
      headers: _headers,
    );

    final data = json.decode(res.body);
    return List<String>.from(data);
  }

  static Future<List<String>> getDistricts(String state) async {
    final res = await http.get(
      Uri.parse(
        "$BASE_URL/dropdown/districts?state=${Uri.encodeComponent(state)}",
      ),
      headers: _headers,
    );

    final data = json.decode(res.body);
    return List<String>.from(data);
  }

  static Future<List<String>> getMarkets(
    String state,
    String district,
  ) async {
    final res = await http.get(
      Uri.parse(
        "$BASE_URL/dropdown/markets"
        "?state=${Uri.encodeComponent(state)}"
        "&district=${Uri.encodeComponent(district)}",
      ),
      headers: _headers,
    );

    final data = json.decode(res.body);
    return List<String>.from(data);
  }

  static Future<List<String>> getCommodities(
    String state,
    String district,
    String market,
  ) async {
    final res = await http.get(
      Uri.parse(
        "$BASE_URL/dropdown/commodities"
        "?state=${Uri.encodeComponent(state)}"
        "&district=${Uri.encodeComponent(district)}"
        "&market=${Uri.encodeComponent(market)}",
      ),
      headers: _headers,
    );

    final data = json.decode(res.body);
    return List<String>.from(data);
  }


  static Future<List<dynamic>> predictPrices({
    required String state,
    required String district,
    required String market,
    required String commodity,
    required int day,
    required int month,
    required int year,
    required int dayOfWeek,
    required double lag1,
    required double lag7,
    required double lag14,
    required double lag30,
    required double rolling7,
    required double rolling14,
    required int days,
  }) async {
    final uri = Uri.parse("$BASE_URL/predict?days=$days");

    final res = await http.post(
      uri,
      headers: _headers,
      body: json.encode({
        "state": state,
        "district_name": district,
        "market_name": market,
        "commodity": commodity,
        "day": day,
        "month": month,
        "year": year,
        "day_of_week": dayOfWeek,
        "lag_1": lag1,
        "lag_7": lag7,
        "lag_14": lag14,
        "lag_30": lag30,
        "rolling_mean_7": rolling7,
        "rolling_mean_14": rolling14,
      }),
    );

    final data = json.decode(res.body);

    if (data["status"] == "success") {
      return data["predictions"];
    } else {
      throw Exception(data["message"] ?? "Prediction failed");
    }
  }
}
