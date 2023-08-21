import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/blocs/comics/comic_bloc.dart';
import 'package:marvel_app/blocs/comics/events/filter_comic_event.dart';
import 'package:marvel_app/blocs/comics/events/load_comics_event.dart';
import 'package:marvel_app/blocs/comics/states/comic_initial_state.dart';
import 'package:marvel_app/modules/home/home_viewmodel.dart';
import '../../blocs/comics/states/comic_state.dart';
import '../../services/dto/response/comic_response_dto.dart';
import '../../services/http_service.dart';

class HomeView extends StatefulWidget {
  final IHttpClient client;

  const HomeView({required this.client, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _viewModel;
  late final ComicBloc comicBloc;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    comicBloc = ComicBloc(client: widget.client);
    comicBloc.add(LoadComicsEvent());

    _viewModel = HomeViewModel();
    _viewModel.init();

    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
  }

  @override
  void dispose() {
    super.dispose();
    comicBloc.close();
    _scrollController.dispose();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      comicBloc.add(LoadComicsEvent());
    }
  }

  showSearchBox(BuildContext context, List<ComicResponseDto> list) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              top: 10,
              left: 10,
              right: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: TextField(
                keyboardType: TextInputType.text,
                onSubmitted: (value) => comicBloc.add(
                  FilterComicEvent(
                    term: value,
                    listComics: list,
                  ),
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pesquisa',
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComicBloc, ComicState>(
      bloc: comicBloc,
      builder: (context, state) {
        if (state is ComicInitialState) {
          return Container(
            color: Colors.lightBlue[400],
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          );
        }

        final list = state.comics;

        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Comics')),
            backgroundColor: Colors.red,
            actions: <Widget>[
              Visibility(
                visible: list.isEmpty,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => comicBloc.add(LoadComicsEvent()),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => showSearchBox(context, list),
              ),
            ],
          ),
          backgroundColor: Colors.lightBlue[400],
          body: Stack(
            children: <Widget>[
              ListView.builder(
                controller: _scrollController,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () =>
                          _viewModel.navigateToDetail(context, list[index].id),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(list[index].thumbnail.fullUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  list[index].title,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              Visibility(
                visible: _viewModel.homeModel.isBusy.value,
                child: Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 24,
                  child: Container(
                    color: Colors.lightBlue[400],
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
