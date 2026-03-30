// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  productId: json['id'] as String,
  productTitle: json['title'] as String,
  productDescription: json['description'] as String,
  productImageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.productId,
      'title': instance.productTitle,
      'description': instance.productDescription,
      'image_url': instance.productImageUrl,
    };
