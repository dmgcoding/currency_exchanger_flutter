import 'package:currency_converter/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/exchange_rates/exchange_rates_cubit.dart';
import 'insert_input.dart';
import 'outputs.dart';

class CurrencyExchangePage extends StatelessWidget {
  const CurrencyExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExchangeRatesCubit(currencyRepo: lc())..getConversionRates(),
      lazy: false,
      child: const CurrencyExchangeView(),
    );
  }
}

class CurrencyExchangeView extends StatelessWidget {
  const CurrencyExchangeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Advanced Exchanger'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: BlocBuilder<ExchangeRatesCubit, ExchangeRatesState>(
          builder: (context, state) {
            if (state.msg.errorMsg != null) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.msg.errorMsg ?? 'Some error occured.'),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => context
                          .read<ExchangeRatesCubit>()
                          .getConversionRates(),
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            }
            if (state.currencyList.isEmpty) {
              return const Center(
                child: Text('Fetching data...'),
              );
            }
            return ListView(
              children: const [
                SizedBox(height: 15),
                InsertInput(),
                Outputs(),
              ],
            );
          },
        ),
      ),
    );
  }
}
