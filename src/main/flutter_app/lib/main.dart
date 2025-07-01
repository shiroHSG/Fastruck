import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'http://10.0.2.2:8080';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = "불러오는 중...";

  @override
  void initState() {
    super.initState();
    fetchMessage();
  }

  Future<void> fetchMessage() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/test'));
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _message = data['message'] ?? '메시지 없음';
        });
      } else {
        setState(() {
          _message = '에러: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _message = '에러 발생: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API 테스트 페이지'),
      ),
      body: Center(
        child: Text(
          _message,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
