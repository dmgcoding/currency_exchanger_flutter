import 'package:currency_converter/core/consts/colors.dart';
import 'package:flutter/material.dart';

class OutuputWidget extends StatelessWidget {
  const OutuputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.grey800,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text('30000.00'),
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
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.delete,
              color: AppColors.red800,
            ),
          ),
        ],
      ),
    );
  }
}
