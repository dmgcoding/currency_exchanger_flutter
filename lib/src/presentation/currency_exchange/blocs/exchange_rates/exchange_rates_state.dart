part of 'exchange_rates_cubit.dart';

@immutable
final class ExchangeRatesState extends Equatable {
  const ExchangeRatesState({
    required this.conversionRates,
    required this.msg,
    required this.input,
    required this.toConvertList,
    required this.currencyList,
  });

  factory ExchangeRatesState.init() => const ExchangeRatesState(
      conversionRates: {},
      msg: UIMessage(),
      input: '',
      toConvertList: ['USD'],
      currencyList: ['USD']);

  final Map<String, double> conversionRates;
  final UIMessage msg;
  final String input;
  final List<String> toConvertList;
  final List<String> currencyList;

  ExchangeRatesState copyWith({
    Map<String, double>? conversionRates,
    UIMessage? msg,
    String? input,
    List<String>? toConvertList,
    List<String>? currencyList,
  }) =>
      ExchangeRatesState(
        conversionRates: conversionRates ?? this.conversionRates,
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
      ];
}
