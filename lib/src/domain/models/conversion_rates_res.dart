// ignore_for_file: sort_constructors_first

class ConversionRatesRes {
  ConversionRatesRes({
    required this.result,
    required this.baseCode,
    required this.conversionRates,
  });
  String result;
  String baseCode;
  Map<String, double> conversionRates;

  factory ConversionRatesRes.fromJson(Map<String, dynamic> json) =>
      ConversionRatesRes(
        result: json['result'] as String,
        baseCode: json['base_code'] as String,
        conversionRates: json['conversion_rates'] as Map<String, double>,
      );

  Map<String, dynamic> toJson() => {
        'result': result,
        'base_code': baseCode,
        'conversion_rates': conversionRates,
      };
}
