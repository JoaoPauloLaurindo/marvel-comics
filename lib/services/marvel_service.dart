import 'dart:convert';

import 'package:marvel_app/services/dto/response/base_response_dto.dart';
import 'package:marvel_app/services/http_service.dart';

import './dto/response/comic_response_dto.dart';

abstract class IMarvelService {
  Future<List<ComicResponseDto>> getComics();
  Future<ComicResponseDto> getComicById(int id);
}

class MarvelService implements IMarvelService {
  final IHttpClient client;

  MarvelService({required this.client});

  @override
  Future<List<ComicResponseDto>> getComics() async {
    final List<ComicResponseDto> listComics = [];
    final response = await client.get(endpoint: '/comics');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final bodyParsed = BaseResponseDto.fromMap(body['data']);

      bodyParsed.results.map((item) {
        final ComicResponseDto comic = ComicResponseDto.fromMap(item);
        listComics.add(comic);
      }).toList();
    }

    return listComics;
  }

  @override
  Future<ComicResponseDto> getComicById(int id) async {
    final List<ComicResponseDto> listComics = [];
    final response = await client.get(endpoint: '/comics/$id');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final bodyParsed = BaseResponseDto.fromMap(body['data']);

      bodyParsed.results.map((item) {
        final ComicResponseDto comic = ComicResponseDto.fromMap(item);
        listComics.add(comic);
      }).toList();
    }

    return listComics.first;
  }
}
