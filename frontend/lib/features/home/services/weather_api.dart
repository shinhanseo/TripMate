import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_response_model.dart';

class WeatherApi {
  final String baseUrl;

  WeatherApi({required this.baseUrl});

  Future<WeatherResponseModel> getJejuWeather() async {
    final url = Uri.parse('$baseUrl/api/weather');

    final response = await http.get(
      url,
      headers: {'Content-type': 'application/json'},
    );

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return WeatherResponseModel.fromJson(json['data']['item']);
    }

    throw Exception(json['message'] ?? '날씨 정보를 불러오지 못했습니다.');
  }
}
