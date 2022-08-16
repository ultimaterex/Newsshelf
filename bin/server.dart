import 'dart:convert';
import 'dart:io';

import 'package:news_shelf/helpers/helper.dart';
import 'package:news_shelf/routes/v1/v1_routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:riverpod/riverpod.dart';


// state of our providers will be stored here
final container = ProviderContainer();

// Configure routes.
Router _router = Router()
  ..get('/', _home)
  ..get('/echo/<message>', _echoHandler)
  ..mount('/v1', V1Routes(container).router)
;


Response _home(Request request) {
  final _aboutApp = {
    'name': 'News Shelf',
    'description': 'A extensible multi-source news fetch api'
  };
  return Response.ok(jsonEncode(_aboutApp));
}

Response _echoHandler(Request request) {
  final message = params(request, 'message');
  return Response.ok('$message\n');
}


void main(List<String> args) async {
  try {
    // Use any available host or container IP (usually `0.0.0.0`).
    final ip = InternetAddress.anyIPv4;

    // Configure a pipeline that logs requests.
    final _handler = Pipeline().addMiddleware(logRequests()).addHandler(
        _router);

    // final handler = SwaggerUI('specs/swagger.yaml', title: 'News Shelf API');

    // For running in containers, we respect the PORT environment variable.
    final port = int.parse(Platform.environment['PORT'] ?? '8080');
    final server = await serve(_handler, ip, port);

    print('Server listening on port $port');
  } on Exception {
    // 4
    Helper.error();
  }
}
