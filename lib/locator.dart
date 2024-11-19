import 'package:currency_converter/src/service/local_storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final lc = GetIt.instance;

Future<void> registerInstances() async {
  final prefs = await SharedPreferences.getInstance();

  lc.registerLazySingleton(() => LocalStorageService(prefs: prefs));
}
