import 'package:flutter_clean_template/core/env/env.dart';

class EnvDev implements Env {
  @override
  String get appName => 'FlutterClean Dev';

  @override
  // TODO: replace with your dev API base URL
  String get baseUrl => 'https://dev-api.example.com';

  @override
  String get applicationId => 'com.example.flutter_clean_template.dev';

  @override
  bool get isDev => true;

  @override
  bool get isStaging => false;

  @override
  bool get isProduction => false;
}
