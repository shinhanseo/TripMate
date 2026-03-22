import 'package:flutter/material.dart';

class RegionChip extends StatelessWidget {
  final String? selectedRegion;
  final ValueChanged<String?> onChanged;

  const RegionChip({
    super.key,
    required this.selectedRegion,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final regions = [
      {'label': '애월/한담권', 'value': '애월/한담권'},
      {'label': '협재/한림권', 'value': '협재/한림권'},
      {'label': '함덕/조천권', 'value': '함덕/조천권'},
      {'label': '성산/우도권', 'value': '성산/우도권'},
      {'label': '표선/성읍권', 'value': '표선/성읍권'},
      {'label': '중문/안덕권', 'value': '중문/안덕권'},
      {'label': '서귀포시내권', 'value': '서귀포시내권'},
      {'label': '제주시/공항권', 'value': '제주시/공항권'},
    ];

    return Wrap(
      spacing: 5,
      runSpacing: 10,
      children: regions.map((gender) {
        final label = gender['label']!;
        final value = gender['value']!;
        final isSelected = selectedRegion == value;

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
              if (isSelected) {
                onChanged(null);
              } else {
                onChanged(value);
              }
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
