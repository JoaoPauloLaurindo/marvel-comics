import 'package:marvel_app/services/dto/response/comic_response_dto.dart';

abstract class ComicState {
  List<ComicResponseDto> comics;

  ComicState({required this.comics});
}
