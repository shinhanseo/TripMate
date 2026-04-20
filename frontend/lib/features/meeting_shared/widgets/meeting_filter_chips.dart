import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/app_choice_chip_group.dart';
import 'package:frontend/features/meeting_shared/utils/meeting_filter_options.dart';

class MeetingCategoryChip extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;
  final bool allowDeselection;

  const MeetingCategoryChip({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
    this.allowDeselection = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppChoiceChipGroup(
      options: meetingCategoryOptions,
      isSelected: (value) => selectedCategory == value,
      onSelected: (value) {
        final shouldClear = allowDeselection && selectedCategory == value;
        onChanged(shouldClear ? null : value);
      },
    );
  }
}

class MeetingCategoryMultiChip extends StatelessWidget {
  final List<String> selectedCategories;
  final ValueChanged<List<String>> onChanged;

  const MeetingCategoryMultiChip({
    super.key,
    required this.selectedCategories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppChoiceChipGroup(
      options: meetingCategoryOptions,
      isSelected: selectedCategories.contains,
      onSelected: (value) {
        final updated = List<String>.from(selectedCategories);

        if (updated.contains(value)) {
          updated.remove(value);
        } else {
          updated.add(value);
        }

        onChanged(updated);
      },
    );
  }
}

class MeetingAgeGroupChip extends StatelessWidget {
  final String? selectedAgeGroup;
  final ValueChanged<String?> onChanged;

  const MeetingAgeGroupChip({
    super.key,
    required this.selectedAgeGroup,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppChoiceChipGroup(
      options: meetingAgeGroupOptions,
      isSelected: (value) => selectedAgeGroup == value,
      onSelected: (value) {
        onChanged(selectedAgeGroup == value ? null : value);
      },
    );
  }
}

class MeetingAgeGroupMultiChip extends StatelessWidget {
  final List<String> selectedAgeGroups;
  final ValueChanged<List<String>> onChanged;

  const MeetingAgeGroupMultiChip({
    super.key,
    required this.selectedAgeGroups,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppChoiceChipGroup(
      options: meetingAgeGroupOptions,
      isSelected: selectedAgeGroups.contains,
      onSelected: (value) {
        final updated = List<String>.from(selectedAgeGroups);

        if (value == 'any') {
          onChanged(['any']);
          return;
        }

        updated.remove('any');

        if (updated.contains(value)) {
          updated.remove(value);
        } else {
          updated.add(value);
        }

        final allSpecificAgesSelected = meetingAgeGroupOptions
            .where((option) => option.value != 'any')
            .every((option) => updated.contains(option.value));

        if (allSpecificAgesSelected) {
          onChanged(['any']);
          return;
        }

        if (updated.isEmpty) {
          updated.add('any');
        }

        onChanged(updated);
      },
    );
  }
}

class MeetingGenderChip extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;
  final bool allowDeselection;

  const MeetingGenderChip({
    super.key,
    required this.selectedGender,
    required this.onChanged,
    this.allowDeselection = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppChoiceChipGroup(
      options: meetingGenderOptions,
      isSelected: (value) => selectedGender == value,
      onSelected: (value) {
        final shouldClear = allowDeselection && selectedGender == value;
        onChanged(shouldClear ? null : value);
      },
    );
  }
}

class MeetingRegionChip extends StatelessWidget {
  final String? selectedRegion;
  final ValueChanged<String?> onChanged;

  const MeetingRegionChip({
    super.key,
    required this.selectedRegion,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppChoiceChipGroup(
      options: meetingRegionOptions,
      isSelected: (value) => selectedRegion == value,
      onSelected: (value) {
        onChanged(selectedRegion == value ? null : value);
      },
    );
  }
}
