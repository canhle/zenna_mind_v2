import 'package:flutter_clean_template/core/env/env.dart';

class EnvStaging implements Env {
  @override
  String get appName => 'FlutterClean Stg';

  @override
  // TODO: replace with your staging API base URL
  String get baseUrl => 'https://stg-api.example.com';

  @override
  String get applicationId => 'com.example.flutter_clean_template.staging';

  @override
  bool get isDev => false;

  @override
  bool get isStaging => true;

  @override
  bool get isProduction => false;
}
