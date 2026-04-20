import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/models/chip_option.dart';

class AppChoiceChipGroup extends StatelessWidget {
  final List<ChipOption> options;
  final bool Function(String value) isSelected;
  final ValueChanged<String> onSelected;

  const AppChoiceChipGroup({
    super.key,
    required this.options,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 10,
      children: options.map((option) {
        final selected = isSelected(option.value);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                spreadRadius: -1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ChoiceChip(
            label: Text(
              option.label,
              style: TextStyle(
                color: selected ? AppColors.blue600 : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            selected: selected,
            onSelected: (_) => onSelected(option.value),
            backgroundColor: AppColors.white,
            selectedColor: AppColors.blue50,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: selected ? AppColors.blue300 : AppColors.gray300,
                width: 1.2,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          ),
        );
      }).toList(),
    );
  }
}
