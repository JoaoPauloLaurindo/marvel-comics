import 'package:flutter/material.dart';
import 'package:marvel_app/modules/comic-detail/comic_detail_parameter.dart';
import 'home_model.dart';

class HomeViewModel {
  late final HomeModel homeModel;

  HomeViewModel();

  void init() async {
    homeModel = HomeModel();
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

  navigateToDetail(BuildContext context, int idComic) async {
    await Navigator.pushNamed(
      context,
      '/comic-detail',
      arguments: ComicDetailParameter(idComic),
    );
  }
}
