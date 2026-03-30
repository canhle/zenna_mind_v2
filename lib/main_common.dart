import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/app.dart';
import 'package:flutter_clean_template/core/env/env.dart';

late Env currentEnv;

void mainCommon(Env env) {
  WidgetsFlutterBinding.ensureInitialized();
  currentEnv = env;

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
