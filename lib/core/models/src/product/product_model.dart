import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';

part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    @Default(0) int id,
    String? title,
    String? description,
    @Default(0) int price,
    @Default(0) double discountPercentage,
    @Default(0) double rating,
    int? stock,
    String? brand,
    String? category,
    String? thumbnail,
    @Default(<String>[]) List<String> images,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
