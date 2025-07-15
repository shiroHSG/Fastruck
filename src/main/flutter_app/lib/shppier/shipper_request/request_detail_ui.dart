import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_theme.dart';
import '../../../widgets/custom_dialog.dart';

class RequestDetailUI extends StatefulWidget {
  const RequestDetailUI({super.key});

  @override
  State<RequestDetailUI> createState() => _RequestDetailUIState();
}

class _RequestDetailUIState extends State<RequestDetailUI> {
  Map<String, String>? acceptedBid;
  bool isAccepted = false;

  List<Map<String, String>> bids = [
    {
      'name': '홍길동',
      'phone': '010-2222-3333',
      'requestTime': '2025.07.02 12:40',
      'price': '500,000원',
      'note': '빠른 배송 부탁드립니다.',
    },
    {
      'name': '김철수',
      'phone': '010-3333-4444',
      'requestTime': '2025.07.02 13:10',
      'price': '480,000원',
      'note': '야간 운행 가능',
    },
  ];

  @override
  void initState() {
    super.initState();
    loadAcceptedBid();
  }

  Future<void> saveAcceptedBid(Map<String, String> bid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAccepted', true);
    prefs.setString('acceptedName', bid['name'] ?? '');
    prefs.setString('acceptedPhone', bid['phone'] ?? '');
    prefs.setString('acceptedPrice', bid['price'] ?? '');
    prefs.setString('acceptedTime', bid['requestTime'] ?? '');
    prefs.setString('acceptedNote', bid['note'] ?? '');
  }

  Future<void> loadAcceptedBid() async {
    final prefs = await SharedPreferences.getInstance();
    final accepted = prefs.getBool('isAccepted') ?? false;

    if (accepted) {
      setState(() {
        isAccepted = true;
        acceptedBid = {
          'name': prefs.getString('acceptedName') ?? '',
          'phone': prefs.getString('acceptedPhone') ?? '',
          'price': prefs.getString('acceptedPrice') ?? '',
          'requestTime': prefs.getString('acceptedTime') ?? '',
          'note': prefs.getString('acceptedNote') ?? '',
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  '상세 정보',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          if (!isAccepted)
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text('작성자 : test'),
                const Text('연락처 : 010-1111-2222'),
                const Text('작성 시간 : 2025.07.02 11:43'),
                const SizedBox(height: 16),
                const Text('출발지 :'),
                const Text('도착지 :'),
                const Text('출발 희망 날짜 :'),
                const Text('운송물품 :'),
                const Text('특이사항 :'),
                const Text('기타 요청사항 :'),

                const SizedBox(height: 30),
                const Divider(color: AppColors.base),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '입찰 신청 현황',
                      style: TextStyle(
                        color: AppColors.point,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    if (isAccepted)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '배정',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 16),

                // 입찰 수락됐으면 다른 입찰 숨기기
                if (isAccepted && acceptedBid != null)
                  _acceptedBidCard(context, acceptedBid!)
                else
                  Column(
                    children: bids.map((bid) => _bidCard(context, bid)).toList(),
                  ),

                Column(
                  children: bids.map((bid) {
                    if (isAccepted && acceptedBid?['name'] == bid['name']) {
                      return const SizedBox(); // 이미 배정된 입찰은 숨김
                    }
                    return _bidCard(context, bid);
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bidCard(BuildContext context, Map<String, String> bid) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.base,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('이름 : ${bid['name']}'),
                    Text('금액 : ${bid['price']}'),
                    const Text('예상 소요 시간 : 3시간'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => BidDetailDialog(
                        name: bid['name']!,
                        phone: bid['phone']!,
                        requestTime: bid['requestTime']!,
                        price: bid['price']!,
                        note: bid['note']!,
                        onAccept: () {
                          Navigator.pop(context);
                          saveAcceptedBid(bid);
                          setState(() {
                            acceptedBid = bid;
                            isAccepted = true;
                          });
                        },
                        onReject: () => Navigator.pop(context),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('보기'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _acceptedBidCard(BuildContext context, Map<String, String> bid) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.base,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('이름 : ${bid['name']}'),
              Text('금액 : ${bid['price']}'),
              Text('요청 시간 : ${bid['requestTime']}'),
              Text('연락처 : ${bid['phone']}'),
              Text('요청사항 : ${bid['note']}'),
            ],
          ),
        ],
      ),
    );
  }
}
