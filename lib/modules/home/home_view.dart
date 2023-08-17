import 'package:flutter/material.dart';
import 'package:marvel_app/services/marvel_service.dart';
import 'home_viewmodel.dart';
import '../../services/http_service.dart';

class HomeView extends StatefulWidget {
  final IHttpClient client;

  const HomeView({required this.client, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _viewModel;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);

    _viewModel =
        HomeViewModel(marvelService: MarvelService(client: widget.client));
    _viewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_viewModel.homeModel.isBusy.value) {
      _viewModel.loadComics();
    }
  }

  showSearchBox(BuildContext context) {
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
                onSubmitted: (value) async =>
                    await _viewModel.filterList(value),
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
    return AnimatedBuilder(
      animation: _viewModel.homeModel,
      builder: (context, item) {
        final list = _viewModel.homeModel.listFilterComics.value;

        if (_viewModel.homeModel.isBusy.value && list.isEmpty) {
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
            title: const Center(child: Text('Comics')),
            backgroundColor: Colors.red,
            actions: <Widget>[
              Visibility(
                visible: list.isEmpty,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => _viewModel.refreshList(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => showSearchBox(context),
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
