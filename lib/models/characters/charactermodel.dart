import 'package:freezed_annotation/freezed_annotation.dart';

part 'charactermodel.freezed.dart';
part 'charactermodel.g.dart';

@freezed
class CharacterModel with _$CharacterModel {
  factory CharacterModel({
    String? id,
    String? name,
    String? image,
    String? status,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}
