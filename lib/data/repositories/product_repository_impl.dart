import 'package:flutter_clean_template/data/datasources/product_remote_datasource.dart';
import 'package:flutter_clean_template/domain/entities/product.dart';
import 'package:flutter_clean_template/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._dataSource);

  final ProductRemoteDataSource _dataSource;

  @override
  Future<List<Product>> getProducts({
    required String categoryId,
    required int page,
  }) async {
    final models = await _dataSource.getProducts(
      categoryId: categoryId,
      page: page,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Product> getProductDetail({required String id}) async {
    final model = await _dataSource.getProductDetail(id: id);
    return model.toEntity();
  }
}
