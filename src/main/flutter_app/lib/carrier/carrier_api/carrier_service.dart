import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/env.dart';

class CarrierService {
  static Future<List<Map<String, dynamic>>> fetchCargoRequests({
    String? departureLocation,
    String? arrivalLocation,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('로그인이 필요합니다.');
    }

    final uri = Uri.parse('${Env.baseUrl}/api/cargo-requests').replace(
      queryParameters: {
        if (departureLocation != null) 'departureLocation': departureLocation,
        if (arrivalLocation != null) 'arrivalLocation': arrivalLocation,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
      return jsonList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('화물 요청 목록 불러오기 실패 (${response.statusCode})');
    }
  }
}
