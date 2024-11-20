import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  const LocalStorageService({required this.prefs});
  final SharedPreferences prefs;

  static const favoriteCurrenciesKey = 'favoriteCurrenciesKey';
  static const conversionRatesKey = 'conversionRatesKey';

  void saveFavoriteCurrency(String curr) {
    final currentString = getString(favoriteCurrenciesKey);
    final currentList = jsonDecode(currentString ?? '[]') as List<dynamic>;
    final convertedCurrentList = currentList.cast<String>();
    if (!convertedCurrentList.contains(curr)) {
      convertedCurrentList.add(curr);
    }
    saveString(favoriteCurrenciesKey, jsonEncode(convertedCurrentList));
  }

  List<String> getFavoritedCurrencies() {
    final str = getString(favoriteCurrenciesKey);
    final list = jsonDecode(str ?? '[]') as List<dynamic>;
    final convertedList = list.cast<String>();
    return convertedList;
  }

  void removeFavoriteCurrency(String curr) {
    final currentString = getString(favoriteCurrenciesKey);
    final currentList = jsonDecode(currentString ?? '[]') as List<dynamic>;
    final convertedList = currentList.cast<String>();
    // ignore: cascade_invocations
    convertedList.remove(curr);
    saveString(favoriteCurrenciesKey, jsonEncode(convertedList));
  }

  void saveConversionRates(Map<String, dynamic> map) {
    saveString(conversionRatesKey, jsonEncode(map));
  }

  Map<String, dynamic> getConversionRates() {
    final ratesStr = getString(conversionRatesKey) ?? '{}';
    final rates = jsonDecode(ratesStr) as Map<String, dynamic>;
    return rates;
  }

  void saveString(String key, String value) {
    prefs.setString(key, value);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future<bool> removeValue(String key) async {
    return prefs.remove(key);
  }
}
