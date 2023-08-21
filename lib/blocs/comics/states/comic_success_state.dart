import '../../../services/dto/response/comic_response_dto.dart';
import 'comic_state.dart';

class ComicSuccessState extends ComicState {
  ComicSuccessState({required List<ComicResponseDto> comics})
      : super(comics: comics);
}
