import 'package:flutter_clean_template/core/env/env_staging.dart';
import 'package:flutter_clean_template/firebase_options_staging.dart';
import 'package:flutter_clean_template/main_common.dart';

void main() {
  mainCommon(EnvStaging(), DefaultFirebaseOptions.currentPlatform);
}
