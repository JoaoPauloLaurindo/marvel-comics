import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

abstract class IHttpClient {
  Future get({required String endpoint});
}

class HttpClient implements IHttpClient {
  final client = http.Client();
  final hash = md5
      .convert(utf8.encode('1${Constants.PRIVATE_KEY}${Constants.PUBLIC_KEY}'));

  @override
  Future get({required String endpoint}) async {
    final String url = getBaseUrl(endpoint);

    return await client.get(Uri.parse(url));
  }

  String getBaseUrl(String endpoint) {
    return '${Constants.BASE_URL}$endpoint?ts=1&apikey=${Constants.PUBLIC_KEY}&hash=$hash';
  }
}
