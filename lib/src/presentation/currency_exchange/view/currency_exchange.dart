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
      create: (context) => ExchangeRatesCubit(currencyRepo: lc()),
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
        child: ListView(
          children: [
            const SizedBox(height: 15),
            InsertInput(),
            Outputs(),
          ],
        ),
      ),
    );
  }
}
