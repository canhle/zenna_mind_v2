import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_list_arguments.freezed.dart';

@freezed
class ProductListArguments with _$ProductListArguments {
  const factory ProductListArguments({
    required String categoryId,
  }) = _ProductListArguments;
}
