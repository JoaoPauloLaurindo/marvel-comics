import '../../../services/dto/response/comic_response_dto.dart';
import 'comic_event.dart';

class LoadComicEvent extends ComicEvent {
  ComicResponseDto comic;

  LoadComicEvent({required this.comic});
}
