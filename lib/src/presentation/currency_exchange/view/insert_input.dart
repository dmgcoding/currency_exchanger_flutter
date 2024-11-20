import 'package:currency_converter/core/consts/colors.dart';
import 'package:currency_converter/locator.dart';
import 'package:currency_converter/src/domain/repos/currency_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/exchange_rates/exchange_rates_cubit.dart';

class InsertInput extends StatelessWidget {
  const InsertInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRatesCubit, ExchangeRatesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('INSERT AMOUNT:'),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.grey800,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'type a value',
                        ),
                        onChanged: (val) {
                          var value = val;
                          if (val == '') value = '0';
                          context
                              .read<ExchangeRatesCubit>()
                              .changeInput(double.parse(value));
                        },
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final flag = lc<CurrencyRepo>()
                            .getCountryFlagFromCurrency(state.inputCurrency);
                        return Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(flag),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 70,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        alignment: AlignmentDirectional.centerEnd,
                        menuMaxHeight: 300,
                        value: state.inputCurrency,
                        hint: const Text(
                          'Select an option',
                        ),
                        items: state.currencyList.map((String item) {
                          return DropdownMenuItem<String>(
                            alignment: AlignmentDirectional.centerEnd,
                            value: item,
                            child: Text(
                              item,
                              textAlign: TextAlign.right,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          context
                              .read<ExchangeRatesCubit>()
                              .changeCurrency(newValue ?? '');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
