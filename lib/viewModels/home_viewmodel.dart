import 'package:flutter/material.dart';
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
      var response = await marvelService.getComics();
      homeModel.listComics.value = response;

      notifyListeners();
    } catch (e) {
      throw 'Houve um erro!';
    }
  }
}
