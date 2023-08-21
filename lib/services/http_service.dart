import 'package:http/http.dart' as http;
import 'package:marvel_app/utils/util.dart';

abstract class IHttpClient {
  Future<dynamic> get({required String endpoint});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future get({required String endpoint}) async {
    final String url = Util.getBaseUrl(endpoint);

    return await client.get(Uri.parse(url));
  }
}
