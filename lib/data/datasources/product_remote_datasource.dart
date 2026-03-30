import 'package:dio/dio.dart';
import 'package:flutter_clean_template/core/network/endpoints.dart';
import 'package:flutter_clean_template/data/models/product_model.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    required String categoryId,
    required int page,
  });

  Future<ProductModel> getProductDetail({required String id});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<ProductModel>> getProducts({
    required String categoryId,
    required int page,
  }) async {
    final response = await _dio.get(
      Endpoints.products,
      queryParameters: {
        'category_id': categoryId,
        'page': page,
      },
    );
    final data = response.data as Map<String, dynamic>;
    return (data['items'] as List)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProductModel> getProductDetail({required String id}) async {
    final response = await _dio.get(Endpoints.productDetail(id));
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }
}
