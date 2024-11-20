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

      final favoritedCurrencies = currencyRepo.getFavoritedCurrencies();
      if (favoritedCurrencies.isEmpty) {
        favoritedCurrencies.add('USD');
      }
      emit(
        state.copyWith(
          conversionRates: conversionRatesMap,
          currencyList: currencyList,
          toConvertList: favoritedCurrencies,
          msg: const UIMessage(),
        ),
      );
    } catch (e) {
      //fetch from local storage in case of error
      final conversionRatesMap = currencyRepo.getConversionRatesFromStorage();
      if (conversionRatesMap.entries.toList().isEmpty) {
        final err = currencyRepo.getErrorMsgFromType(e.toString());
        emit(
          state.copyWith(
            msg: UIMessage(errorMsg: err),
          ),
        );
      } else {
        final currencyList = conversionRatesMap.keys.toList();
        emit(
          state.copyWith(
            conversionRates: conversionRatesMap,
            currencyList: currencyList,
            msg: const UIMessage(),
          ),
        );
      }
    }
  }

  void changeInput(double val) {
    emit(state.copyWith(input: val));
  }

  void changeCurrency(String val) {
    emit(state.copyWith(inputCurrency: val));
  }

  void addCurrencyToFavorite(String curr) {
    currencyRepo.saveFavoriteCurrency(curr);
  }

  void addCurrencyToConvert() {
    final currentList = state.toConvertList;
    final updatedList = [...currentList, 'USD'];
    emit(state.copyWith(toConvertList: updatedList));
  }

  void removeFromCurrencyToConvert(int index, String curr) {
    currencyRepo.removeFavoritedCurrency(curr);
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
