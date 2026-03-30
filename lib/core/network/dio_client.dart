import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/core/network/auth_interceptor.dart';
import 'package:flutter_clean_template/core/network/endpoints.dart';
import 'package:flutter_clean_template/core/network/error_interceptor.dart';
import 'package:flutter_clean_template/core/services/storage_service.dart';

part 'dio_client.g.dart';

@riverpod
Dio dioClient(Ref ref) {
  final storage = ref.read(storageServiceProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  dio.interceptors.addAll([
    AuthInterceptor(storage),
    ErrorInterceptor(),
  ]);
  return dio;
}
