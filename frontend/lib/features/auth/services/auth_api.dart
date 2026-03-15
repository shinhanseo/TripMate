import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response_model.dart';

class AuthApi {
  final String baseUrl;

  AuthApi({required this.baseUrl});

  String getNaverLoginUrl() {
    // naver 로그인 시 리다이렉트할 url
    return '$baseUrl/api/auth/naver';
  }

  Future<LoginResponseModel> exchangeCode(String exchangeCode) async {
    // naver 회원가입 직후 받은 정보와 exchange_code로 닉네임 생성 화면 분기
    final url = Uri.parse('$baseUrl/api/auth/session/exchange');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'exchange_code': exchangeCode}),
    );

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return LoginResponseModel.fromJson(json['data']);
    }

    throw Exception(json['message'] ?? '로그인에 실패했습니다.');
  }
}
