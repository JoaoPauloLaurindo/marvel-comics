import 'package:flutter/material.dart';
import 'package:marvel_app/services/marvel_service.dart';
import '../services/dto/response/comic_response_dto.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Comics')),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.lightBlue[400],
      body: ValueListenableBuilder(
          valueListenable: viewModel.homeModel.listComics,
          builder: (context, List<ComicResponseDto> item, _) {
            final comics = viewModel.homeModel.listComics.value;
            if (comics.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
            return ListView.builder(
              itemCount: comics.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () =>
                        viewModel.navigateToDetail(context, comics[index].id),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(comics[index].thumbnail.fullUrl),
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
                                comics[index].title,
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
            );
          }),
    );
  }
}
