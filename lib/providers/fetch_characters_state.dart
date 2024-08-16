import 'package:flutter_query/models/characters/charactermodel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_characters_state.freezed.dart';

@freezed
class FetchCharactersState with _$FetchCharactersState {
  factory FetchCharactersState.initial() = _Initial;
  factory FetchCharactersState.fetching() = _Fetching;
  factory FetchCharactersState.fetched(List<CharacterModel> characters) = _Fetched;
  factory FetchCharactersState.failed(String error) = _Failed;
}
