import 'package:flutter/material.dart';
import 'package:marvel_app/services/http_service.dart';
import 'package:marvel_app/services/marvel_service.dart';
import 'package:marvel_app/viewModels/comic_detail_viewModel.dart';

class ComicDetailView extends StatefulWidget {
  final int idComic;
  const ComicDetailView({required this.idComic, super.key});

  @override
  State<ComicDetailView> createState() => _ComicDetailViewState();
}

class _ComicDetailViewState extends State<ComicDetailView> {
  ComicDetailViewModel viewModel =
      ComicDetailViewModel(marvelService: MarvelService(client: HttpClient()));

  @override
  void initState() {
    viewModel.init(widget.idComic);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.comicModel.comic,
      builder: (context, item, _) {
        final comic = viewModel.comicModel.comic.value;

        if (viewModel.comicModel.isBusy.value) {
          return Container(
            color: Colors.lightBlue[400],
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(viewModel.comicModel.comic.value.title),
            ),
            backgroundColor: Colors.red,
          ),
          body: ListView(
            children: <Widget>[
              Image.network(comic.thumbnail.fullUrl),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        'Páginas: ',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${comic.pageCount}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
