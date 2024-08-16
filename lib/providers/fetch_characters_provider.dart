import 'package:dio/dio.dart';
import 'package:flutter_query/models/characters/charactermodel.dart';
import 'package:flutter_query/providers/fetch_characters_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FetchCharactersProvider extends StateNotifier<FetchCharactersState> {
  FetchCharactersProvider(super.state);

  fetchCharacter() async {
    state = FetchCharactersState.fetching();

    try {
      Dio dio = Dio();
      final response =
          await dio.post('https://rickandmortyapi.com/graphql', data: {
        "query": r'''
query {
  characters{
    results{
      id
      name
      image
      status      
    }
  }
}
'''
      });

      List<dynamic> responseData =
          response.data['data']['characters']['results'];

      // final characters = await ApiService().fetchCharacters();
      state = FetchCharactersState.fetched(responseData
          .map(
            (e) => CharacterModel.fromJson(e),
          )
          .toList());
    } on DioException catch (e) {
      state = FetchCharactersState.failed(e.message ?? 'error');
    } catch (e) {
      state = FetchCharactersState.failed('Failed to fetch characters');
    }
  }
}

final fetchCharacterProvider =
    StateNotifierProvider<FetchCharactersProvider, FetchCharactersState>(
  (ref) =>
      FetchCharactersProvider(FetchCharactersState.initial())..fetchCharacter(),
);
