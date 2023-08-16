import 'package:flutter/material.dart';
import 'package:marvel_app/modules/comic-detail/comic_detail_parameter.dart';
import 'package:marvel_app/services/http_service.dart';
import 'package:marvel_app/modules/comic-detail/comic_detail_view.dart';
import 'modules/home/home_view.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final IHttpClient httpClient = HttpClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeView(client: httpClient),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/comic-detail') {
          final args = settings.arguments as ComicDetailParameter;

          return MaterialPageRoute(
            builder: (context) {
              return ComicDetailView(
                httpClient: httpClient,
                param: args,
              );
            },
          );
        }
        return null;
      },
    );
  }
}
