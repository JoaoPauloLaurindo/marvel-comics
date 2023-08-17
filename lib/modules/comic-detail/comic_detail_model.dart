import 'package:flutter/material.dart';
import 'package:marvel_app/services/dto/response/comic_response_dto.dart';

class ComicDetailModel extends ChangeNotifier {
  ValueNotifier<ComicResponseDto> comic =
      ValueNotifier<ComicResponseDto>(ComicResponseDto.empty());

  ValueNotifier<bool> isBusy = ValueNotifier<bool>(false);

  void save() {
    notifyListeners();
  }
}
