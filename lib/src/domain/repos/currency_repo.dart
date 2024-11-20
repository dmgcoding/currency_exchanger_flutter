import 'package:currency_converter/src/service/country_service.dart';
import 'package:currency_converter/src/service/currency_service.dart';
import 'package:currency_converter/src/service/local_storage_service.dart';

class CurrencyRepo {
  CurrencyRepo({
    required this.currencyService,
    required this.countryService,
    required this.localStorageService,
  });
  final CurrencyService currencyService;
  final CountryService countryService;
  final LocalStorageService localStorageService;

  Map<String, dynamic> _conversionRates = {};

  String getCountryFlagFromCurrency(String curr) {
    final countryCode = countryService.getCountryCodeFromCurrencyCode(curr);
    if (countryCode == null) {
      return 'https://cdn.pixabay.com/photo/2014/05/24/00/07/woven-cloth-352481_1280.jpg';
    }
    return 'https://flagcdn.com/w320/$countryCode.png';
  }

  Future<Map<String, dynamic>> getConversionRates() async {
    try {
      final res = await currencyService.fetchConversionRates();
      _conversionRates = res.conversionRates;
      localStorageService.saveConversionRates(_conversionRates);
      return res.conversionRates;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> getConversionRatesFromStorage() {
    try {
      final rates = localStorageService.getConversionRates();
      return rates;
    } catch (e) {
      rethrow;
    }
  }

  List<String> getFavoritedCurrencies() {
    return localStorageService.getFavoritedCurrencies();
  }

  void saveFavoriteCurrency(String curr) {
    localStorageService.saveFavoriteCurrency(curr);
  }

  void removeFavoritedCurrency(String curr) {
    localStorageService.removeFavoriteCurrency(curr);
  }

  String getConvertedValue({
    required double input,
    required String inputCurr,
    required String convertToCurr,
  }) {
    //get dollar value
    final inputCurrValue = convertToDouble(_conversionRates[inputCurr]);
    final usdVal = input / inputCurrValue;
    //convertToCurr value * dollar value
    final convertToCurrValue = convertToDouble(_conversionRates[convertToCurr]);
    final convertedResult = usdVal * convertToCurrValue;
    return convertedResult.toString();
  }

  double convertToDouble(dynamic val) {
    if (val.runtimeType == int) {
      return (val as int).toDouble();
    }
    if (val == null) return 0;
    return val as double;
  }

  //https://www.exchangerate-api.com/docs/standard-requests
  // "unsupported-code" if we don't support the supplied currency code (see supported currencies...).
  // "malformed-request" when some part of your request doesn't follow the structure shown above.
  // "invalid-key" when your API key is not valid.
  // "inactive-account" if your email address wasn't confirmed.
  // "quota-reached" when your account has reached the the number of requests allowed by your plan.
  String getErrorMsgFromType(String type) {
    switch (type) {
      case 'unsupported-code':
        return "Api doesn't support this currency.";
      case 'malformed-request':
        return 'Error due to malformed request.';
      case 'invalid-key':
        return 'Api key is not valid.';
      case 'inactive-account':
        return 'Inactive account related to api key.';
      case 'quota-reached':
        return 'Monthly quota reached.';
      default:
        return 'Some error happend';
    }
  }
}
