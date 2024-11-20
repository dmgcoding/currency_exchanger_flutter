part of 'exchange_rates_cubit.dart';

@immutable
final class ExchangeRatesState extends Equatable {
  const ExchangeRatesState({
    required this.conversionRates,
    required this.msg,
    required this.input,
    required this.toConvertList,
    required this.currencyList,
    required this.inputCurrency,
  });

  factory ExchangeRatesState.init() => const ExchangeRatesState(
        conversionRates: {},
        msg: UIMessage(),
        input: 0,
        toConvertList: [],
        currencyList: ['USD'],
        inputCurrency: 'USD',
      );

  final Map<String, dynamic> conversionRates;
  final UIMessage msg;
  final double input;
  final List<String> toConvertList;
  final List<String> currencyList;
  final String inputCurrency;

  ExchangeRatesState copyWith({
    Map<String, dynamic>? conversionRates,
    UIMessage? msg,
    double? input,
    String? inputCurrency,
    List<String>? toConvertList,
    List<String>? currencyList,
  }) =>
      ExchangeRatesState(
        conversionRates: conversionRates ?? this.conversionRates,
        inputCurrency: inputCurrency ?? this.inputCurrency,
        msg: msg ?? this.msg,
        input: input ?? this.input,
        toConvertList: toConvertList ?? this.toConvertList,
        currencyList: currencyList ?? this.currencyList,
      );

  @override
  List<Object?> get props => [
        conversionRates,
        msg,
        input,
        toConvertList,
        currencyList,
        inputCurrency,
      ];
}
