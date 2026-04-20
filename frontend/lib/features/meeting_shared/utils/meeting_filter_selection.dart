class MeetingFilterSelection {
  final String? category;
  final String? ageGroup;
  final String? gender;
  final String? regionPrimary;

  const MeetingFilterSelection({
    this.category,
    this.ageGroup,
    this.gender,
    this.regionPrimary,
  });

  const MeetingFilterSelection.empty()
    : category = null,
      ageGroup = null,
      gender = null,
      regionPrimary = null;
}
