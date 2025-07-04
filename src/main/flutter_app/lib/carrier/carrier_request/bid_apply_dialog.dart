import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_theme.dart';

class BidApplyDialog extends StatefulWidget {
  const BidApplyDialog({super.key});

  @override
  State<BidApplyDialog> createState() => _BidApplyDialogState();
}

class _BidApplyDialogState extends State<BidApplyDialog> {
  String name = '';
  String phone = '';

  // 입력 컨트롤러
  final TextEditingController priceController = TextEditingController(); // 금액
  final TextEditingController timeController = TextEditingController();  // 예상 소요 시간
  final TextEditingController noteController = TextEditingController();  // 기타 전달사항

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      phone = prefs.getString('phone') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHorizontalReadOnlyField('이름', name),
            _buildHorizontalReadOnlyField('연락처', phone),
            _buildHorizontalTextField('금액', controller: priceController, suffixText: '원'),
            _buildHorizontalTextField('예상 소요 시간', controller: timeController),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('기타 전달 사항:', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '선택사항',
                // 기타 전달사항의 테두리 색상 설정
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // 👉 취소 버튼
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[300],
            foregroundColor: AppColors.point,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: const Text('취소'),
        ),
        // 확인 버튼
        TextButton(
          onPressed: () {
            final bidData = {
              'name': name,
              'phone': phone,
              'price': priceController.text,
              'time': timeController.text,
              'note': noteController.text,
            };
            Navigator.pop(context, bidData);
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: const Text('확인'),
        ),
      ],
    );
  }

  // 읽기전용 필드 (이름, 연락처)
  Widget _buildHorizontalReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 왼쪽 라벨
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // 오른쪽 회색 박스에 텍스트
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.base,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }

  // 입력 필드 (금액, 시간)
  Widget _buildHorizontalTextField(String label,
      {required TextEditingController controller, String? suffixText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 왼쪽 라벨
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // 오른쪽 입력창
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                suffixText: suffixText,
                filled: true,
                fillColor: AppColors.base,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
