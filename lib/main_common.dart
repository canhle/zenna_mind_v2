import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_template/app.dart';
import 'package:flutter_clean_template/core/env/env.dart';

late Env currentEnv;

Future<void> mainCommon(Env env, FirebaseOptions firebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();
  currentEnv = env;

  await Firebase.initializeApp(options: firebaseOptions);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
