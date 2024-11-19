class ExchangeRateApi {
  static String fetchRates(String apiKey, String currencyCode) =>
      '/$apiKey/latest/$currencyCode';
}
