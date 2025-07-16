import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_theme.dart';
import 'shipper_request_ui.dart';
import 'request_write.dart';
import '../../main.dart'; // baseUrl 선언되어있으면 import

class ShipperRequestPage extends StatefulWidget {
  const ShipperRequestPage({super.key});

  @override
  State<ShipperRequestPage> createState() => _ShipperRequestPageState();
}

class _ShipperRequestPageState extends State<ShipperRequestPage> {
  int selectedMonth = DateTime.now().month;
  late Future<List<Map<String, dynamic>>> _requestFuture;

  @override
  void initState() {
    super.initState();
    _requestFuture = fetchRequests(selectedMonth);
  }

  void onMonthChanged(int month) {
    setState(() {
      selectedMonth = month;
      _requestFuture = fetchRequests(month);
    });
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

  // status 매핑: 영어 → 한글 표기
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

  // 화주 cargo-requests API 호출 (ex. /api/cargo-requests?month=7)
  Future<List<Map<String, dynamic>>> fetchRequests(int month) async {
    // 1. 토큰을 SharedPreferences에서 가져오기
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/api/cargo-requests?month=$month'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('API Status: ${response.statusCode}');
    print('API Body: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      print('Parsed Data: $data');
      return data.map<Map<String, dynamic>>((item) {
        return {
          'id': item['id'], // 상세페이지 이동용
          'from': item['departureLocation'] ?? '',
          'to': item['arrivalLocation'] ?? '',
          'pickupTime': item['pickupTime'],
          'deliveryTime': item['deliveryTime'],
          'cargoType': item['cargoType'] ?? '',
          'status': mapStatus(item['status']),
        };
      }).toList();
    } else {
      print('API Error!');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _requestFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('에러: ${snapshot.error}'));
          }
          final allRequests = snapshot.data ?? [];

          // 날짜 info필드 생성
          List<Map<String, dynamic>> mappedList = allRequests.map((item) {
            return {
              'id': item['id'],
              'from': item['from'],
              'to': item['to'],
              'info':
              '${formatDateTime(item['pickupTime'])} 출발 / '
                  '${formatDateTime(item['deliveryTime'])} 도착예정 / '
                  '${item['cargoType']} 운송',
              'status': item['status'],
            };
          }).toList();

          return ShipperRequestUI(
            selectedMonth: selectedMonth,
            requestList: mappedList,
            onMonthChanged: onMonthChanged,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 글 작성 페이지로 이동
          debugPrint('글쓰기 버튼 클릭됨');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RequestWritePage()),
          ).then((_) {
            setState(() {
              _requestFuture = fetchRequests(selectedMonth);
            });
          });
        },
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.edit, color: AppColors.white),
      ),
    );
  }
}
