import 'package:flutter/material.dart';
import 'package:marvel_app/modules/comic-detail/comic_detail_parameter.dart';
import 'home_model.dart';
import '../../services/marvel_service.dart';

class HomeViewModel {
  late IMarvelService marvelService;
  late final HomeModel homeModel;

  HomeViewModel({required this.marvelService});

  void init() async {
    homeModel = HomeModel();
    await loadComics();
  }

  Future loadComics() async {
    try {
      homeModel.isBusy.value = true;
      var response = await marvelService.getComics();

      for (var i = 0; i < response.length; i++) {
        homeModel.listFilterComics.value.add(response[i]);
        homeModel.listComics.value.add(response[i]);
      }

      homeModel.currentPage.value += 10;
      homeModel.isBusy.value = false;

      homeModel.save();
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

      homeModel.save();
    } catch (e) {
      throw 'Houve um erro: $e';
    }
  }

  refreshList() async {
    homeModel.currentPage.value = 1;
    await loadComics();
  }

  navigateToDetail(BuildContext context, int idComic) async {
    await Navigator.pushNamed(
      context,
      '/comic-detail',
      arguments: ComicDetailParameter(idComic),
    );
  }
}
