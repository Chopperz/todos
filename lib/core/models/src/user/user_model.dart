import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    int? id,
    String? firstName,
    String? lastName,
    String? maidenName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    String? image,
    String? username,
    String? password,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
