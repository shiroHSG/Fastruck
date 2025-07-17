import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;  // ← 서버 POST를 위해 추가!
import 'dart:convert';
import '../../../app_theme.dart';
import 'address_search_page.dart';
import '../../main.dart'; // baseUrl

class RequestWritePage extends StatefulWidget {
  const RequestWritePage({super.key});

  @override
  State<RequestWritePage> createState() => _RequestWritePageState();
}

class _RequestWritePageState extends State<RequestWritePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController departureController = TextEditingController();
  final TextEditingController departureDetailController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();
  final TextEditingController arrivalDetailController = TextEditingController();
  final TextEditingController departureDateController = TextEditingController();
  final TextEditingController arrivalDateController = TextEditingController();
  final TextEditingController cargoTypeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? '';
    final phone = prefs.getString('phone') ?? '';

    setState(() {
      nameController.text = name;
      phoneController.text = phone;
    });

    print('[불러온 정보] 이름: $name, 연락처: $phone');
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy.MM.dd').format(picked);
    }
  }

  Future<void> _searchAddress(TextEditingController controller) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddressSearchPage()),
    );
    if (result != null && result is String) {
      setState(() {
        controller.text = result;
      });
    }
  }

  /// 날짜포맷 "yyyy.MM.dd" -> "yyyy-MM-ddT00:00:00" 변환
  String? _convertToIsoDate(String dateStr) {
    if (dateStr.isEmpty) return null;
    try {
      final dt = DateFormat('yyyy.MM.dd').parse(dateStr);
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dt);
    } catch (_) {
      return null;
    }
  }

  Future<void> _registerCargo() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken') ?? '';

    final requestData = {
      "requestContent": memoController.text,
      "departureLocation": departureController.text,
      "arrivalLocation": arrivalController.text,
      "cargoType": cargoTypeController.text,
      "weight": double.tryParse(weightController.text) ?? 0.0,
      "pickupTime": _convertToIsoDate(departureDateController.text),
      "deliveryTime": _convertToIsoDate(arrivalDateController.text),
      "expectedTime": "", // 필요시 값 입력
    };

    print('[화물등록 요청] $requestData');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/cargo-requests'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestData),
      );

      print('[화물등록 응답] status=${response.statusCode} body=${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('성공'),
            content: const Text('화물 요청이 등록되었습니다!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // 다이얼로그 닫기
                  Navigator.pop(context, true); // 등록화면 닫고, 이전화면에 true 반환
                },
                child: const Text('확인'),
              ),
            ],
          ),
        );
      } else {
        _showDialog('등록 실패: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      _showDialog('등록 중 오류 발생: $e');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('알림'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    departureController.dispose();
    departureDetailController.dispose();
    arrivalController.dispose();
    arrivalDetailController.dispose();
    departureDateController.dispose();
    arrivalDateController.dispose();
    cargoTypeController.dispose();
    weightController.dispose();
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration inputStyle({String? hint}) {
      return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.base.withOpacity(0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('화물 등록', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 이름 / 연락처
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    readOnly: true,
                    decoration: inputStyle(hint: '이름'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    readOnly: true,
                    decoration: inputStyle(hint: '연락처'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 출발지
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: departureController,
                    decoration: inputStyle(hint: '출발지'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _searchAddress(departureController),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    minimumSize: const Size(10, 48),
                  ),
                  child: const Text('주소검색'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: departureDetailController,
              decoration: inputStyle(hint: '상세주소 입력'),
            ),
            const SizedBox(height: 16),

            // 도착지
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: arrivalController,
                    decoration: inputStyle(hint: '도착지'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _searchAddress(arrivalController),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    minimumSize: const Size(10, 48),
                  ),
                  child: const Text('주소검색'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: arrivalDetailController,
              decoration: inputStyle(hint: '상세주소 입력'),
            ),
            const SizedBox(height: 16),

            // 날짜
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: departureDateController,
                    readOnly: true,
                    onTap: () => _selectDate(departureDateController),
                    decoration: inputStyle(hint: '출발날짜'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: arrivalDateController,
                    readOnly: true,
                    onTap: () => _selectDate(arrivalDateController),
                    decoration: inputStyle(hint: '도착 희망날짜'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 운송물품 / 무게
            TextField(
              controller: cargoTypeController,
              decoration: inputStyle(hint: '운송물품'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: inputStyle(hint: '무게'),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('t'),
              ],
            ),
            const SizedBox(height: 16),

            // 기타 요청사항
            TextField(
              controller: memoController,
              maxLines: 3,
              decoration: inputStyle(hint: '기타 요청사항'),
            ),
            const SizedBox(height: 24),

            // 버튼
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('삭제'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _registerCargo, // ← 등록 함수 연결!
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('확인'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
