import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/region_summary_model.dart';

class RegionSummaryApi {
  final String baseUrl;

  RegionSummaryApi({required this.baseUrl});

  Future<RegionSummaryModel> getRegionSummary({
    required String accessToken,
  }) async {
    final url = Uri.parse('$baseUrl/api/meeting/home');

    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return RegionSummaryModel.fromJson(json['data']['item']);
    }

    throw Exception(json['message'] ?? "동행 요약 정보를 불러오지 못했습니다.");
  }
}
