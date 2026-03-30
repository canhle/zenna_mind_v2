import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_template/domain/entities/product.dart';
import 'package:flutter_clean_template/domain/repositories/product_repository.dart';
import 'package:flutter_clean_template/domain/usecases/product/get_products_usecase.dart';

void main() {
  late GetProductsUseCase sut;
  late _FakeProductRepository repository;

  setUp(() {
    repository = _FakeProductRepository();
    sut = GetProductsUseCase(repository);
  });

  group('call', () {
    test('should return products from repository', () async {
      // Arrange
      repository.productsToReturn = _dummyProducts();

      // Act
      final result = await sut(categoryId: 'cat_1', page: 0);

      // Assert
      expect(result, _dummyProducts());
    });

    test('should throw ArgumentError when page is negative', () async {
      // Arrange & Act & Assert
      expect(
        () => sut(categoryId: 'cat_1', page: -1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}

// ── Fakes ──────────────────────────────────────────────────────────────────────

class _FakeProductRepository implements ProductRepository {
  List<Product> productsToReturn = [];

  @override
  Future<List<Product>> getProducts({
    required String categoryId,
    required int page,
  }) async {
    return productsToReturn;
  }

  @override
  Future<Product> getProductDetail({required String id}) async {
    return productsToReturn.first;
  }
}

// ── Dummy data ─────────────────────────────────────────────────────────────────

List<Product> _dummyProducts() => const [
      Product(
        id: 'p_001',
        title: 'Sample Product',
        description: 'A sample product description',
        imageUrl: 'https://example.com/image.png',
      ),
      Product(
        id: 'p_002',
        title: 'Another Product',
        description: 'Another product description',
      ),
    ];
