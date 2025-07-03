import 'package:flutter/material.dart';
import 'package:flutter_app/shppier/shipper_home/shipper_request/request_detail_ui.dart';
import '../../../widgets/custom_dialog.dart';


class RequestDetailPage extends StatelessWidget {
  const RequestDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: RequestDetailUI(),
    );
  }
}

  void _showBidDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const BidDetailDialog(
        name: '홍길동',
        phone: '010-2222-3333',
        requestTime: '2025.07.02 12:40',
        price: '500,000원',
        note: '빠른 배송 부탁드립니다.',
      ),
    );
  }

