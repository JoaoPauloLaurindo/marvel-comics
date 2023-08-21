import 'package:bloc/bloc.dart';
import 'package:marvel_app/blocs/comics/events/comic_event.dart';
import 'package:marvel_app/blocs/comics/events/filter_comic_event.dart';
import 'package:marvel_app/blocs/comics/events/load_comics_event.dart';
import 'package:marvel_app/blocs/comics/states/comic_initial_state.dart';
import 'package:marvel_app/blocs/comics/states/comic_success_state.dart';
import 'package:marvel_app/services/dto/response/comic_response_dto.dart';
import 'package:marvel_app/services/http_service.dart';

import '../../services/marvel_service.dart';
import 'states/comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  final IHttpClient client;

  late final IMarvelService _marvelService;

  ComicBloc({required this.client}) : super(ComicInitialState()) {
    _marvelService = MarvelService(client: client);

    on<LoadComicsEvent>(
      (event, emit) async =>
          emit(ComicSuccessState(comics: await _marvelService.getComics())),
    );
    on<FilterComicEvent>(
      (event, emit) {
        List<ComicResponseDto> comics = [];

        if (event.listComics.isNotEmpty) {
          comics = event.listComics
              .where((element) => element.title.contains(event.term))
              .toList();
        }

        emit(ComicSuccessState(comics: comics));
      },
    );
  }
}
