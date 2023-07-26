import 'dart:convert';

import 'package:marvel_app/services/http_service.dart';

import './dto/response/comic_response_dto.dart';

abstract class IMarvelService {
  Future<List<ComicResponseDto>> getComics();
}

class MarvelService implements IMarvelService {
  final IHttpClient client;

  MarvelService({required this.client});

  @override
  Future<List<ComicResponseDto>> getComics() async {
    final List<ComicResponseDto> listComics = [];
    final response = await client.get(endpoint: '/comics');
    print(response.body);

    if (response == 200) {
      final body = jsonDecode(response.body);

      body.data['results'].map((item) {
        final ComicResponseDto comic = ComicResponseDto.fromMap(item);
        listComics.add(comic);
      });
    }

    return listComics;
  }
}
