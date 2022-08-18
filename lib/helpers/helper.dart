import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:shelf/shelf.dart';

class Helper {
  static String randomChars(int length) {
    final random = Random.secure();
    const acceptable =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(length,
        (v) => acceptable.codeUnitAt(random.nextInt(acceptable.length))));
  }

  static Response error({String? message}) {
    return Response.internalServerError(
        body: jsonEncode({'message': (message ?? 'There was an error')}));
  }

  static String hash(String password, {int rounds: 200}) {
    var bytes = <int>[];
    final salt = 'You might want to add your own salt to the hash :]'.codeUnits;
    for (var i = 0; i < rounds; i++) {
      bytes = sha256.convert([...bytes, ...password.codeUnits, ...salt]).bytes;
    }
    return Digest(bytes).toString();
  }
}
