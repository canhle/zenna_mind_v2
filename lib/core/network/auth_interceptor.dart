import 'package:dio/dio.dart';
import 'package:flutter_clean_template/core/services/storage_service.dart';

class AuthInterceptor extends Interceptor {
  const AuthInterceptor(this._storage);

  final StorageService _storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getSecure(StorageKeys.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
