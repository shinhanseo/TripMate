import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class AgeGroupChip extends StatelessWidget {
  final String? selectedAgeGroup;
  final ValueChanged<String?> onChanged;

  const AgeGroupChip({
    super.key,
    required this.selectedAgeGroup,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ageGroups = [
      {'label': '연령 무관', 'value': 'any'},
      {'label': '20대', 'value': '20s'},
      {'label': '30대', 'value': '30s'},
      {'label': '40대', 'value': '40s'},
      {'label': '50대', 'value': '50s'},
    ];

    return Wrap(
      spacing: 5,
      runSpacing: 10,
      children: ageGroups.map((ageGroup) {
        final label = ageGroup['label']!;
        final value = ageGroup['value']!;
        final isSelected = selectedAgeGroup == value;

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
              label,
              style: TextStyle(
                color: isSelected ? AppColors.blue600 : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            selected: isSelected,
            onSelected: (_) {
              if (isSelected) {
                onChanged(null);
              } else {
                onChanged(value);
              }
            },
            backgroundColor: AppColors.white,
            selectedColor: AppColors.blue50,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? AppColors.blue300 : AppColors.gray300,
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
