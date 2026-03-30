abstract class Env {
  String get appName;
  String get baseUrl;
  String get applicationId;

  bool get isDev => false;
  bool get isStaging => false;
  bool get isProduction => false;
}
