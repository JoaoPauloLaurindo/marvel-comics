import 'dart:async';

import 'package:marvel_app/blocs/comics/events/comic_event.dart';
import 'package:marvel_app/blocs/comics/events/filter_comic_event.dart';
import 'package:marvel_app/blocs/comics/events/load_comic_event.dart';
import 'package:marvel_app/blocs/comics/events/load_comics_event.dart';
import 'package:marvel_app/blocs/comics/states/comic_success_state.dart';
import 'package:marvel_app/services/dto/response/comic_response_dto.dart';
import 'package:marvel_app/services/http_service.dart';

import '../../services/marvel_service.dart';
import 'states/comic_state.dart';

class ComicBloc {
  final IMarvelService _marvelService = MarvelService(client: HttpClient());

  final StreamController<ComicEvent> _inputComicController =
      StreamController<ComicEvent>();
  final StreamController<ComicState> _outputComicController =
      StreamController<ComicState>();

  Sink<ComicEvent> get inputComic => _inputComicController.sink;
  Stream<ComicState> get stream => _outputComicController.stream;

  ComicBloc() {
    _inputComicController.stream.listen(_mapEventToState);
  }

  _mapEventToState(ComicEvent event) async {
    List<ComicResponseDto> comics = [];

    if (event is LoadComicsEvent) {
      comics = await _marvelService.getComics();
    } else if (event is LoadComicEvent) {
      comics.add(event.comic);
    } else if (event is FilterComicEvent) {
      comics = event.listComics
          .where((element) => element.title.contains(event.term))
          .toList();
    }
    //TO-DO: Fazer implementação de favoritos

    _outputComicController.add(ComicSuccessState(comics: comics));
  }
}
