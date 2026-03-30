import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_clean_template/data/providers/product_data_providers.dart';
import 'package:flutter_clean_template/domain/entities/product.dart';
import 'package:flutter_clean_template/domain/usecases/product/get_products_usecase.dart';

part 'product_domain_providers.g.dart';

@riverpod
GetProductsUseCase getProductsUseCase(Ref ref) =>
    GetProductsUseCase(ref.read(productRepositoryProvider));

@riverpod
Future<List<Product>> products(
  Ref ref, {
  required String categoryId,
  required int page,
}) =>
    ref.read(getProductsUseCaseProvider)(
      categoryId: categoryId,
      page: page,
    );
