import 'package:grpc/grpc.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class AppDataRepository {
  final apiProvider = ApiProvider();

  Future<ResponseStream<Country>> getAllCountries() =>
      apiProvider.listAllCountries();

  Future<ResponseStream<Language>> getAllLanguages() =>
      apiProvider.listAllLanguages();
}
