import 'package:flutter/material.dart';
import 'review_detail_ui.dart';

class ReviewDetailPage extends StatefulWidget {
  final String name;
  final String phone;
  final String requestTime;
  final String price;
  final String note;
  final String estimatedArrival;
  final String actualArrival;
  final int rating;
  final String reviewContent;

  const ReviewDetailPage({
    super.key,
    required this.name,
    required this.phone,
    required this.requestTime,
    required this.price,
    required this.note,
    required this.estimatedArrival,
    required this.actualArrival,
    required this.rating,
    required this.reviewContent,
  });

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ReviewDetailUI(
      name: widget.name,
      phone: widget.phone,
      requestTime: widget.requestTime,
      price: widget.price,
      note: widget.note,
      estimatedArrival: widget.estimatedArrival,
      actualArrival: widget.actualArrival,
      rating: widget.rating,
      reviewContent: widget.reviewContent,
    );
  }
}
