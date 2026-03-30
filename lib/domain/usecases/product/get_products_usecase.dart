import 'package:flutter_clean_template/domain/entities/product.dart';
import 'package:flutter_clean_template/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  const GetProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<List<Product>> call({
    required String categoryId,
    required int page,
  }) async {
    if (page < 0) throw ArgumentError('Page must be non-negative');

    return _repository.getProducts(
      categoryId: categoryId,
      page: page,
    );
  }
}
