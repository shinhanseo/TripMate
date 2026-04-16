import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

class AgeGroupChip extends StatelessWidget {
  final List<String> selectedAgeGroups;
  final ValueChanged<List<String>> onChanged;

  const AgeGroupChip({
    super.key,
    required this.selectedAgeGroups,
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
        final isSelected = selectedAgeGroups.contains(value);

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
              final updated = List<String>.from(selectedAgeGroups);

              if (value == 'any') {
                onChanged(['any']);
                return;
              }

              updated.remove('any');

              if (isSelected) {
                updated.remove(value);
              } else {
                updated.add(value);
              }

              if ([
                '20s',
                '30s',
                '40s',
                '50s',
              ].every((e) => updated.contains(e))) {
                onChanged(['any']);
                return;
              }

              if (updated.isEmpty) {
                updated.add('any');
              }

              onChanged(updated);
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
