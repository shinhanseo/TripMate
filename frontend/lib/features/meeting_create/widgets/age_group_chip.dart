import 'package:flutter/material.dart';

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
                color: isSelected ? const Color(0xFF2563EB) : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            selected: isSelected,
            onSelected: (_) {
              final updated = List<String>.from(selectedAgeGroups);

              if (value == 'any') {
                // 연령 무관 선택 시 나머지 전부 해제
                onChanged(['any']);
                return;
              }

              // 다른 연령 선택 시 'any' 제거
              updated.remove('any');

              if (isSelected) {
                updated.remove(value);
              } else {
                updated.add(value);
              }

              // 아무것도 없으면 다시 'any'로 복귀시키고 싶을 때
              if (updated.isEmpty) {
                updated.add('any');
              }

              onChanged(updated);
            },
            backgroundColor: const Color(0xffffffff),
            selectedColor: const Color(0xFFE8F0FE),
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? const Color(0xFF93C5FD)
                    : const Color(0xffD1D5DB),
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
