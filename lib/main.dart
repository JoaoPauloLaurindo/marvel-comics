import 'package:flutter/material.dart';
import 'package:marvel_app/blocs/comics/comic_bloc.dart';
import 'package:marvel_app/modules/comic-detail/comic_detail_parameter.dart';
import 'package:marvel_app/services/http_service.dart';
import 'package:marvel_app/modules/comic-detail/comic_detail_view.dart';
import 'package:marvel_app/services/marvel_service.dart';
import 'package:provider/provider.dart';
import 'modules/home/home_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: IHttpClient),
        ProxyProvider(
            update: ((context, value, previous) =>
                MarvelService(client: context.read()))),
        ProxyProvider(
            update: ((context, value, previous) =>
                ComicBloc(client: context.read()))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomeView(client: context.watch()),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/comic-detail') {
            final args = settings.arguments as ComicDetailParameter;

            return MaterialPageRoute(
              builder: (context) {
                return ComicDetailView(
                  httpClient: context.watch(),
                  param: args,
                );
              },
            );
          }
          return null;
        },
      ),
    );
  }
}
