import 'package:flutter/foundation.dart';
import '../models/weather_response_model.dart';
import '../services/weather_api.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherApi weatherApi;

  WeatherViewModel({required this.weatherApi});

  WeatherResponseModel? weather;
  bool isLoading = false;
  String? errorMessage;
  bool _hasLoaded = false;

  Future<void> loadWeather() async {
    if (_hasLoaded || isLoading) return;

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await weatherApi.getJejuWeather();
      weather = result;
      _hasLoaded = true;
    } catch (e) {
      errorMessage = '날씨 정보를 불러오지 못했습니다.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
