import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_theme.dart';
import 'request_detail_ui.dart';
import '../../main.dart'; // baseUrl 선언

class RequestDetailPage extends StatefulWidget {
  final int id;
  const RequestDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  late Future<Map<String, dynamic>> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = fetchDetail(widget.id);
  }

  // 날짜 배열 -> "07.16 00:00"
  String formatDateTime(List<dynamic>? arr) {
    if (arr == null || arr.length < 5) return '';
    final month = arr[1].toString().padLeft(2, '0');
    final day = arr[2].toString().padLeft(2, '0');
    final hour = arr[3].toString().padLeft(2, '0');
    final min = arr[4].toString().padLeft(2, '0');
    return '$month.$day $hour:$min';
  }

  // 상태 영어 → 한글
  String mapStatus(dynamic raw) {
    switch ((raw ?? '').toString().toUpperCase()) {
      case 'OPEN':
      case 'UNASSIGNED':
        return '미배정';
      case 'ASSIGNED':
        return '배정';
      case 'COMPLETE':
      case 'DELIVERED':
        return '배송완료';
      default:
        return raw?.toString() ?? '';
    }
  }

  Future<Map<String, dynamic>> fetchDetail(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/api/cargo-requests/$id'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return data;
    } else {
      throw Exception('상세 정보를 불러오지 못했습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _detailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('에러: ${snapshot.error}')),
          );
        }
        final data = snapshot.data!;

        // 값 가공
        final status = mapStatus(data['status']);
        final pickupTime = formatDateTime(data['pickupTime']);
        final deliveryTime = formatDateTime(data['deliveryTime']);
        final departure = data['departureLocation'] ?? '';
        final arrival = data['arrivalLocation'] ?? '';
        final cargoType = data['cargoType'] ?? '';
        final weight = (data['weight'] == null || data['weight'].toString().isEmpty) ? '-' : data['weight'].toString();
        final expectedTime = data['expectedTime'] ?? '';
        final requestContent = data['requestContent'] ?? '';
        final shipperName = data['shipperName'] ?? '';
        final shipperPhone = data['shipperPhone'] ?? '';
        final carrierName = data['carrierName'];
        final carrierPhone = data['carrierPhone'];

        // 차주 정보 조건 출력
        final bool showCarrier =
            (status == '배정' || status == '배송완료') &&
                carrierName != null && carrierPhone != null &&
                carrierName.toString().trim().isNotEmpty && carrierPhone.toString().trim().isNotEmpty;

        // RequestDetailUI로 넘길 데이터 Map
        final Map<String, dynamic> detail = {
          'status': status,
          'departure': departure,
          'arrival': arrival,
          'cargoType': cargoType,
          'weight': weight,
          'requestContent': requestContent,
          'pickupTime': pickupTime,
          'deliveryTime': deliveryTime,
          'shipperName': shipperName,
          'shipperPhone': shipperPhone,
          'expectedTime': expectedTime,
          'showCarrier': showCarrier,
          'carrierName': carrierName ?? '',
          'carrierPhone': carrierPhone ?? '',
        };

        return Scaffold(
          backgroundColor: Colors.white,
          body: RequestDetailUI(detail: detail),
        );
      },
    );
  }
}
