import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class RequestDetailUI extends StatelessWidget {
  final Map<String, dynamic> detail;
  const RequestDetailUI({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    // 안전하게 데이터 가져오기 (빈값이면 ‘-’로)
    String getVal(String? v, {String defaultValue = '-'}) =>
        (v == null || v.trim().isEmpty) ? defaultValue : v;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 타이틀/뒤로가기/상태
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Text(
                  '화물 상세 정보',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    getVal(detail['status'], defaultValue: ''),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 출발지 → 도착지
                Row(
                  children: [
                    Text(
                      getVal(detail['departure']),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const Text(' → ', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                    Text(
                      getVal(detail['arrival']),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                Text('화주: ${getVal(detail['shipperName'])}'),
                Text('연락처: ${getVal(detail['shipperPhone'])}'),
                const SizedBox(height: 10),

                Text('출발 시간: ${getVal(detail['pickupTime'])}'),
                Text('도착 시간: ${getVal(detail['deliveryTime'])}'),
                const SizedBox(height: 10),

                Text('운송 물품: ${getVal(detail['cargoType'])}'),
                Text('무게: ${getVal(detail['weight'])} kg'),
                Text('예상 소요시간: ${getVal(detail['expectedTime'])}'),
                const SizedBox(height: 10),

                Text('요청 내용: ${getVal(detail['requestContent'])}'),

                // 차주 정보(배정, 배송완료 상태일 때만)
                if (detail['showCarrier'] == true)
                  ...[
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text('배정 차주: ${getVal(detail['carrierName'])}'),
                    Text('차주 연락처: ${getVal(detail['carrierPhone'])}'),
                  ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
