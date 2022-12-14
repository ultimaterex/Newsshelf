import 'package:dotenv/dotenv.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';

final credentialsProvider = Provider((ref) => Credentials());

class Credentials {
  late String gnewsApiKey;

  // Define required api keys here
  static const _requiredEnvVars = ['gnewsapi'];

  Credentials() {
    final env = DotEnv(includePlatformEnvironment: true)..load([".env"]);

    if (env.isEveryDefined(_requiredEnvVars)){
      gnewsApiKey = env['gnewsapi']!;
    } else {
      Logger().e('Required Environment Variables have not been defined');
      throw Exception('Required Environment Variables have not been defined');
    }
  }
}