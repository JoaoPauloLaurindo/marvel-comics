import 'package:marvel_app/services/marvel_service.dart';

import 'comic_detail_model.dart';

class ComicDetailViewModel {
  late IMarvelService marvelService;
  late final ComicDetailModel comicModel;

  ComicDetailViewModel({required this.marvelService});

  void init(int idComic) async {
    comicModel = ComicDetailModel();
    await loadComicDetail(idComic);
  }

  Future loadComicDetail(int idComic) async {
    try {
      comicModel.isBusy.value = true;

      var response = await marvelService.getComicById(idComic);
      comicModel.comic.value = response;
      comicModel.isBusy.value = false;

      comicModel.dispose();
    } catch (e) {
      throw 'Houve um erro!';
    }
  }
}
