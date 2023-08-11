import 'package:flutter/material.dart';
import 'package:marvel_app/views/comic_detail_view.dart';
import '../models/home_model.dart';
import '../services/marvel_service.dart';

class HomeViewModel extends ChangeNotifier {
  late IMarvelService marvelService;
  HomeModel homeModel = HomeModel();

  HomeViewModel({required this.marvelService});

  void init() async {
    await loadComics();
  }

  Future loadComics() async {
    try {
      homeModel.isBusy.value = true;
      var response = await marvelService.getComics();
      homeModel.listComics.value = homeModel.listFilterComics.value = response;
      homeModel.isBusy.value = false;

      notifyListeners();
    } catch (e) {
      throw 'Houve um erro!';
    }
  }

  Future filterList(String search) async {
    try {
      homeModel.isBusy.value = true;
      final filter = homeModel.listComics.value
          .where((element) => element.title.contains(search))
          .toList();
      homeModel.listFilterComics.value = filter;
      homeModel.isBusy.value = false;

      notifyListeners();
    } catch (e) {
      throw 'Houve um erro: $e';
    }
  }

  refreshList() {
    homeModel.listFilterComics.value = homeModel.listComics.value;

    notifyListeners();
  }

  navigateToDetail(BuildContext context, int idComic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ComicDetailView(idComic: idComic),
      ),
    );
  }
}
