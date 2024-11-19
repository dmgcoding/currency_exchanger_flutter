import 'package:bloc/bloc.dart';
import 'package:currency_converter/src/domain/models/ui_message.dart';
import 'package:currency_converter/src/domain/repos/currency_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'exchange_rates_state.dart';

class ExchangeRatesCubit extends Cubit<ExchangeRatesState> {
  ExchangeRatesCubit({required this.currencyRepo})
      : super(ExchangeRatesState.init());
  final CurrencyRepo currencyRepo;

  Future<void> getConversionRates() async {
    try {
      final conversionRatesMap = await currencyRepo.getConversionRates();
      final currencyList = conversionRatesMap.keys.toList();
      emit(
        state.copyWith(
          conversionRates: conversionRatesMap,
          currencyList: currencyList,
        ),
      );
    } catch (e) {
      //TODO: REMOVE PRINT
      print(e);
      final err = currencyRepo.getErrorMsgFromType(e.toString());
      emit(
        state.copyWith(
          msg: UIMessage(errorMsg: err),
        ),
      );
    }
  }

  void changeInput(double val) {
    emit(state.copyWith(input: val));
  }

  void changeCurrency(String val) {
    emit(state.copyWith(inputCurrency: val));
  }

  void addCurrencyToConvert() {
    final currentList = state.toConvertList;
    final updatedList = [...currentList, 'USD'];
    emit(state.copyWith(toConvertList: updatedList));
  }

  void removeFromCurrencyToConvert(int index) {
    final currentList = state.toConvertList;
    final updatedList = <String>[];
    for (var i = 0; i < currentList.length; i++) {
      if (index != i) {
        updatedList.add(currentList[i]);
      }
    }
    emit(state.copyWith(toConvertList: updatedList));
  }
}
