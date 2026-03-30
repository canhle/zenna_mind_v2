class Endpoints {
  Endpoints._();

  static const String baseUrl = 'https://api.example.com';

  // Products
  static const String products = '/api/products';
  static String productDetail(String id) => '/api/products/$id';
}
