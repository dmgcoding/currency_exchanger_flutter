import 'package:currency_converter/core/consts/colors.dart';
import 'package:currency_converter/src/presentation/currency_exchange/blocs/exchange_rates/exchange_rates_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'output_widget.dart';

class Outputs extends StatelessWidget {
  const Outputs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CONVERT TO:'),
          const SizedBox(height: 12),
          BlocBuilder<ExchangeRatesCubit, ExchangeRatesState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.toConvertList
                    .asMap()
                    .entries
                    .map(
                      (entry) => OutuputWidget(
                        index: entry.key,
                        cur: entry.value,
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 25),
          Align(
            child: GestureDetector(
              onTap: () =>
                  context.read<ExchangeRatesCubit>().addCurrencyToConvert(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.green800,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    Text('ADD CONVERTER'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
