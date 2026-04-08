import 'package:flutter_clean_template/core/env/env_dev.dart';
import 'package:flutter_clean_template/firebase_options_dev.dart';
import 'package:flutter_clean_template/main_common.dart';

void main() {
  mainCommon(EnvDev(), DefaultFirebaseOptions.currentPlatform);
}
