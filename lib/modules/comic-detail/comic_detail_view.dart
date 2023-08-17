import 'package:flutter/material.dart';
import 'package:marvel_app/modules/comic-detail/comic_detail_parameter.dart';
import 'package:marvel_app/services/http_service.dart';
import 'package:marvel_app/services/marvel_service.dart';
import 'package:marvel_app/modules/comic-detail/comic_detail_viewModel.dart';

class ComicDetailView extends StatefulWidget {
  final IHttpClient httpClient;
  final ComicDetailParameter param;
  const ComicDetailView(
      {required this.httpClient, required this.param, super.key});

  @override
  State<ComicDetailView> createState() => _ComicDetailViewState();
}

class _ComicDetailViewState extends State<ComicDetailView> {
  late ComicDetailViewModel viewModel;
  late Object? parameter;

  @override
  void initState() {
    viewModel = ComicDetailViewModel(
      marvelService: MarvelService(
        client: widget.httpClient,
      ),
    );

    viewModel.init(widget.param.idComic);

    super.initState();
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
