// lib/config/env.dart

class Env {
  //기본 http://10.0.2.2:8080로 연결
  static const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'http://10.0.2.2:8080');
}