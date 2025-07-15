import 'package:flutter/material.dart';
import 'package:flutter_app/shppier/shipper_request/request_detail_ui.dart';

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
