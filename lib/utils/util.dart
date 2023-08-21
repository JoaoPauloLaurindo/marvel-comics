import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'constants.dart';

class Util {
  static String getBaseUrl(String endpoint) {
    final hash = getHash();
    return '${Constants.BASE_URL}$endpoint?ts=1&apikey=${Constants.PUBLIC_KEY}&hash=$hash';
  }

  static Digest getHash() {
    return md5.convert(
        utf8.encode('1${Constants.PRIVATE_KEY}${Constants.PUBLIC_KEY}'));
  }
}
