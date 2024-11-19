import 'package:currency_converter/core/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InsertInput extends StatelessWidget {
  const InsertInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('INSERT AMOUNT:'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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
                      hintText: '100.00',
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://flagcdn.com/w320/us.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 70,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    alignment: AlignmentDirectional.centerEnd,
                    value: 'USD', // Current selected value
                    hint: const Text(
                        'Select an option'), // Placeholder when no value is selected
                    items: ['USD', 'GBP'].map((String item) {
                      return DropdownMenuItem<String>(
                        alignment: AlignmentDirectional.centerEnd,
                        value: item,
                        child: Text(
                          item,
                          textAlign: TextAlign.right,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
