import 'package:flutter/material.dart';
import '../../../app_theme.dart';
import '../carrier_api/carrier_service.dart';
import 'carrier_request_ui.dart';

class CarrierRequestPage extends StatefulWidget {
  const CarrierRequestPage({super.key});

  @override
  State<CarrierRequestPage> createState() => _CarrierRequestPageState();
}

class _CarrierRequestPageState extends State<CarrierRequestPage> {
  String selectedFilter = '전체';
  String searchQuery = '';
  List<Map<String, dynamic>> allRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRequests();
  }

  Future<void> loadRequests() async {
    try {
      final rawData = await CarrierService.fetchCargoRequests();

      final converted = rawData.map((item) {
        return {
          'from': item['departureLocation'],
          'to': item['arrivalLocation'],
          'info':
          '${item['pickupTime'].substring(0, 10)} 출발 / ${item['deliveryTime'].substring(0, 10)} 도착예정 / ${item['cargoType']} 운송',
          'status': item['status'], // '입찰중' 또는 '입찰완료'로 변환해도 됨
          'id': item['id'], // 상세페이지로 넘길 용도
        };
      }).toList();

      setState(() {
        allRequests = converted;
        isLoading = false;
      });
    } catch (e) {
      print('에러 발생: $e');
      setState(() => isLoading = false);
    }
  }

  List<Map<String, dynamic>> get filteredList {
    return allRequests.where((item) {
      final matchFilter = selectedFilter == '전체' || item['status'] == selectedFilter;
      final matchSearch = item['departureLocation'].toString().contains(searchQuery) ||
          item['arrivalLocation'].toString().contains(searchQuery) ||
          item['cargoType'].toString().contains(searchQuery);
      return matchFilter && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CarrierRequestUI(
        requestList: filteredList,
        selectedFilter: selectedFilter,
        onFilterChanged: (value) {
          if (value != null) {
            setState(() => selectedFilter = value);
          }
        },
        searchQuery: searchQuery,
        onSearchChanged: (value) {
          setState(() => searchQuery = value);
        },
      ),
    );
  }
}
