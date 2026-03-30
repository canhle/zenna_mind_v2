import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_clean_template/domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  const ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productDescription,
    this.productImageUrl,
  });

  @JsonKey(name: 'id')
  final String productId;

  @JsonKey(name: 'title')
  final String productTitle;

  @JsonKey(name: 'description')
  final String productDescription;

  @JsonKey(name: 'image_url')
  final String? productImageUrl;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  Product toEntity() => Product(
        id: productId,
        title: productTitle,
        description: productDescription,
        imageUrl: productImageUrl,
      );
}
