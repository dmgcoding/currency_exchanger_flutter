import 'package:currency_converter/core/consts/colors.dart';
import 'package:currency_converter/locator.dart';
import 'package:currency_converter/src/domain/repos/currency_repo.dart';
import 'package:currency_converter/src/presentation/currency_exchange/blocs/exchange_rates/exchange_rates_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutuputWidget extends StatefulWidget {
  const OutuputWidget({
    required this.index,
    required this.cur,
    super.key,
  });

  final int index;
  final String cur;

  @override
  State<OutuputWidget> createState() => _OutuputWidgetState();
}

class _OutuputWidgetState extends State<OutuputWidget> {
  String _selectedCurrency = 'USD';
  @override
  void initState() {
    setState(() {
      _selectedCurrency = widget.cur;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRatesCubit, ExchangeRatesState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 7),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.grey800,
          ),
          child: Row(
            children: [
              Expanded(
                child: Builder(
                  builder: (context) {
                    final text = lc<CurrencyRepo>().getConvertedValue(
                      input: state.input,
                      inputCurr: state.inputCurrency,
                      convertToCurr: _selectedCurrency,
                    );
                    return Text(text == '0.0' ? '-' : text);
                  },
                ),
              ),
              Builder(
                builder: (context) {
                  final flag = lc<CurrencyRepo>()
                      .getCountryFlagFromCurrency(_selectedCurrency);
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
                  menuMaxHeight: 300,
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  alignment: AlignmentDirectional.centerEnd,
                  value: _selectedCurrency,
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
                    setState(() {
                      _selectedCurrency = newValue ?? 'USD';
                    });
                    context
                        .read<ExchangeRatesCubit>()
                        .addCurrencyToFavorite(_selectedCurrency);
                  },
                ),
              ),
              IconButton(
                onPressed: () => context
                    .read<ExchangeRatesCubit>()
                    .removeFromCurrencyToConvert(
                      widget.index,
                      _selectedCurrency,
                    ),
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.red800,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
