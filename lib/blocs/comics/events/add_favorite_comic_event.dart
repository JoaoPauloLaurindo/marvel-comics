import 'comic_event.dart';
import '../../../services/dto/response/comic_response_dto.dart';

class AddFavoriteComicEvent extends ComicEvent {
  ComicResponseDto comic;

  AddFavoriteComicEvent({required this.comic});
}
