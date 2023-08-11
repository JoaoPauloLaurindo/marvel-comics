import 'package:flutter/material.dart';
import '../services/dto/response/comic_response_dto.dart';

class HomeModel extends ChangeNotifier {
  ValueNotifier<List<ComicResponseDto>> listComics =
      ValueNotifier<List<ComicResponseDto>>([]);

  ValueNotifier<List<ComicResponseDto>> listFilterComics =
      ValueNotifier<List<ComicResponseDto>>([]);

  ValueNotifier<bool> isBusy = ValueNotifier<bool>(false);
}
