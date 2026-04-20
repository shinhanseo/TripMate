import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/features/meeting_shared/utils/meeting_filter_selection.dart';
import 'package:frontend/features/meeting_shared/widgets/meeting_filter_chips.dart';

Future<MeetingFilterSelection?> showMeetingFilterBottomSheet({
  required BuildContext context,
  required MeetingFilterSelection initialSelection,
}) {
  var tempSelection = initialSelection;

  return showModalBottomSheet<MeetingFilterSelection>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (modalContext) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          void updateSelection(MeetingFilterSelection selection) {
            setModalState(() {
              tempSelection = selection;
            });
          }

          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.gray300,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '필터',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const _FilterSectionTitle('카테고리'),
                    MeetingCategoryChip(
                      selectedCategory: tempSelection.category,
                      onChanged: (value) {
                        updateSelection(
                          MeetingFilterSelection(
                            category: value,
                            ageGroup: tempSelection.ageGroup,
                            gender: tempSelection.gender,
                            regionPrimary: tempSelection.regionPrimary,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const _FilterSectionTitle('연령'),
                    MeetingAgeGroupChip(
                      selectedAgeGroup: tempSelection.ageGroup,
                      onChanged: (value) {
                        updateSelection(
                          MeetingFilterSelection(
                            category: tempSelection.category,
                            ageGroup: value,
                            gender: tempSelection.gender,
                            regionPrimary: tempSelection.regionPrimary,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const _FilterSectionTitle('성별'),
                    MeetingGenderChip(
                      selectedGender: tempSelection.gender,
                      onChanged: (value) {
                        updateSelection(
                          MeetingFilterSelection(
                            category: tempSelection.category,
                            ageGroup: tempSelection.ageGroup,
                            gender: value,
                            regionPrimary: tempSelection.regionPrimary,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    const _FilterSectionTitle('지역'),
                    MeetingRegionChip(
                      selectedRegion: tempSelection.regionPrimary,
                      onChanged: (value) {
                        updateSelection(
                          MeetingFilterSelection(
                            category: tempSelection.category,
                            ageGroup: tempSelection.ageGroup,
                            gender: tempSelection.gender,
                            regionPrimary: value,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              updateSelection(
                                const MeetingFilterSelection.empty(),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(52),
                              side: const BorderSide(color: AppColors.gray300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              '초기화',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(modalContext, tempSelection);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(52),
                              backgroundColor: AppColors.brandMint,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              '적용',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class _FilterSectionTitle extends StatelessWidget {
  final String text;

  const _FilterSectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}
