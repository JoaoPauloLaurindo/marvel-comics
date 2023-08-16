import 'package:flutter/material.dart';
import 'package:marvel_app/services/marvel_service.dart';

import 'comic_detail_model.dart';

class ComicDetailViewModel extends ChangeNotifier {
  late IMarvelService marvelService;
  ComicDetailModel comicModel = ComicDetailModel();

  ComicDetailViewModel({required this.marvelService});

  void init(int idComic) async {
    await loadComicDetail(idComic);
  }

  Future loadComicDetail(int idComic) async {
    try {
      comicModel.isBusy.value = true;

      var response = await marvelService.getComicById(idComic);
      comicModel.comic.value = response;
      comicModel.isBusy.value = false;

      notifyListeners();
    } catch (e) {
      throw 'Houve um erro!';
    }
  }
}
