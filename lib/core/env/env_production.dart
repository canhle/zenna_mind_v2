import 'package:flutter_clean_template/core/env/env.dart';

class EnvProduction implements Env {
  @override
  String get appName => 'FlutterClean';

  @override
  // TODO: replace with your production API base URL
  String get baseUrl => 'https://api.example.com';

  @override
  String get applicationId => 'com.example.flutter_clean_template';

  @override
  bool get isDev => false;

  @override
  bool get isStaging => false;

  @override
  bool get isProduction => true;
}
