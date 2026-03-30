import 'package:flutter_clean_template/domain/entities/product.dart';

abstract interface class ProductRepository {
  Future<List<Product>> getProducts({
    required String categoryId,
    required int page,
  });

  Future<Product> getProductDetail({required String id});
}
