import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  const LocalStorageService({required this.prefs});
  final SharedPreferences prefs;
}
