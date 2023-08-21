import '../../../services/dto/response/comic_response_dto.dart';
import 'comic_event.dart';

class FilterComicEvent extends ComicEvent {
  String term;
  List<ComicResponseDto> listComics;

  FilterComicEvent({required this.term, required this.listComics});
}
