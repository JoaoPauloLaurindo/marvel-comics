import 'package:flutter/material.dart';
import 'package:marvel_app/services/marvel_service.dart';
import '../viewModels/home_viewmodel.dart';
import '../services/http_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel viewModel =
      HomeViewModel(marvelService: MarvelService(client: HttpClient()));

  @override
  void initState() {
    viewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
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
                onSubmitted: (value) async => await viewModel.filterList(value),
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
    return ValueListenableBuilder(
      valueListenable: viewModel.homeModel.listFilterComics,
      builder: (context, item, _) {
        final list = viewModel.homeModel.listFilterComics.value;

        if (viewModel.homeModel.isBusy.value) {
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
                  onPressed: () => viewModel.refreshList(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => showSearchBox(context),
              ),
            ],
          ),
          backgroundColor: Colors.lightBlue[400],
          body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () =>
                      viewModel.navigateToDetail(context, list[index].id),
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
        );
      },
    );
  }
}
