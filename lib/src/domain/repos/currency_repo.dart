import 'package:currency_converter/src/service/currency_service.dart';

class CurrencyRepo {
  const CurrencyRepo({required this.currencyService});
  final CurrencyService currencyService;

  Future<Map<String, double>> getConversionRates() async {
    try {
      final res = await currencyService.fetchConversionRates();
      return res.conversionRates;
    } catch (e) {
      rethrow;
    }
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
