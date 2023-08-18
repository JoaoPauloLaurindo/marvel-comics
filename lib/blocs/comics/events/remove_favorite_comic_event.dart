import '../../../services/dto/response/comic_response_dto.dart';
import 'comic_event.dart';

class RemoveFavoriteComicEvent extends ComicEvent {
  ComicResponseDto comic;

  RemoveFavoriteComicEvent({required this.comic});
}
