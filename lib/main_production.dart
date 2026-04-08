import 'package:flutter_clean_template/core/env/env_production.dart';
import 'package:flutter_clean_template/firebase_options_production.dart';
import 'package:flutter_clean_template/main_common.dart';

void main() {
  mainCommon(EnvProduction(), DefaultFirebaseOptions.currentPlatform);
}
