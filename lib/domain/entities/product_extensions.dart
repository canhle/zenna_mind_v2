import 'package:flutter_clean_template/domain/entities/product.dart';

extension ProductExtensions on Product {
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  String get shortDescription {
    if (description.length <= 100) return description;
    return '${description.substring(0, 97)}...';
  }
}
