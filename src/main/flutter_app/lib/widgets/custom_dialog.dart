import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class BidDetailDialog extends StatelessWidget {
  final String name;
  final String phone;
  final String requestTime;
  final String price;
  final String note;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const BidDetailDialog({
    super.key,
    required this.name,
    required this.phone,
    required this.requestTime,
    required this.price,
    required this.note,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이름 : $name'),
          Text('연락처 : $phone'),
          Text('요청 시간 : $requestTime'),
          const SizedBox(height: 12),
          Text('금액 : $price'),
          Text('기타 전달사항 : $note'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onReject ?? () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          child: const Text('거절'),
        ),
        TextButton(
          onPressed: onAccept ?? () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primary,
          ),
          child: const Text('수락'),
        ),
      ],
    );
  }
}
