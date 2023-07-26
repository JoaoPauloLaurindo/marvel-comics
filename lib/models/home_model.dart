import 'package:flutter/material.dart';
import '../services/dto/response/comic_response_dto.dart';

class HomeModel extends ChangeNotifier {
  ValueNotifier<List<ComicResponseDto>> listComics =
      ValueNotifier<List<ComicResponseDto>>([]);
}
