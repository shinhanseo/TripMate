import 'package:frontend/core/models/chip_option.dart';

const meetingCategoryOptions = [
  ChipOption(label: '☕ 카페', value: 'cafe'),
  ChipOption(label: '🍜 식사', value: 'food'),
  ChipOption(label: '🏄 액티비티', value: 'activity'),
  ChipOption(label: '🍺 술', value: 'drink'),
  ChipOption(label: '🚗 관광', value: 'tour'),
];

const meetingAgeGroupOptions = [
  ChipOption(label: '연령 무관', value: 'any'),
  ChipOption(label: '20대', value: '20s'),
  ChipOption(label: '30대', value: '30s'),
  ChipOption(label: '40대', value: '40s'),
  ChipOption(label: '50대', value: '50s'),
];

const meetingGenderOptions = [
  ChipOption(label: '성별 무관', value: 'any'),
  ChipOption(label: '남성', value: 'male'),
  ChipOption(label: '여성', value: 'female'),
];

const meetingRegionOptions = [
  ChipOption(label: '애월/한담권', value: '애월/한담권'),
  ChipOption(label: '협재/한림권', value: '협재/한림권'),
  ChipOption(label: '함덕/조천권', value: '함덕/조천권'),
  ChipOption(label: '성산/우도권', value: '성산/우도권'),
  ChipOption(label: '표선/성읍권', value: '표선/성읍권'),
  ChipOption(label: '중문/안덕권', value: '중문/안덕권'),
  ChipOption(label: '서귀포시내권', value: '서귀포시내권'),
  ChipOption(label: '제주시/공항권', value: '제주시/공항권'),
];

String meetingCategoryLabel(String value) {
  return _labelFor(meetingCategoryOptions, value);
}

String meetingAgeGroupLabel(String value) {
  return _labelFor(meetingAgeGroupOptions, value);
}

String meetingGenderLabel(String value) {
  return _labelFor(meetingGenderOptions, value);
}

List<String> meetingCategoryLabels(Iterable<String> values) {
  return meetingCategoryOptions
      .where((option) => values.contains(option.value))
      .map((option) => option.label)
      .toList();
}

String meetingFilterSummary({
  required String? category,
  required String? ageGroup,
  required String? gender,
  required String? regionPrimary,
}) {
  final values = <String>[];

  if (category != null && category.isNotEmpty) {
    values.add(meetingCategoryLabel(category));
  }

  if (ageGroup != null && ageGroup.isNotEmpty) {
    values.add(meetingAgeGroupLabel(ageGroup));
  }

  if (gender != null && gender.isNotEmpty) {
    values.add(meetingGenderLabel(gender));
  }

  if (regionPrimary != null && regionPrimary.isNotEmpty) {
    values.add(regionPrimary);
  }

  if (values.isEmpty) {
    return '전체 필터';
  }

  return values.join(' · ');
}

bool hasMeetingFilters({
  required String? category,
  required String? ageGroup,
  required String? gender,
  required String? regionPrimary,
  String query = '',
}) {
  return (category != null && category.isNotEmpty) ||
      (ageGroup != null && ageGroup.isNotEmpty) ||
      (gender != null && gender.isNotEmpty) ||
      (regionPrimary != null && regionPrimary.isNotEmpty) ||
      query.trim().isNotEmpty;
}

String _labelFor(List<ChipOption> options, String value) {
  return options
      .firstWhere(
        (option) => option.value == value,
        orElse: () => ChipOption(label: value, value: value),
      )
      .label;
}
