import 'package:currency_converter/src/domain/repos/currency_repo.dart';
import 'package:currency_converter/src/service/currency_service.dart';
import 'package:currency_converter/src/service/local_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final lc = GetIt.instance;

Future<void> initializeDependecies() async {
  final prefs = await SharedPreferences.getInstance();

  lc
    ..registerLazySingleton(() => LocalStorageService(prefs: prefs))
    ..registerLazySingleton(
      () => CurrencyRepo(currencyService: CurrencyService()),
    );
}
