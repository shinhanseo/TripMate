class RegionSummaryModel {
  final String regionPrimary;
  final String firstCategory;
  final int totalCount;
  final String summaryText;

  RegionSummaryModel({
    required this.regionPrimary,
    required this.firstCategory,
    required this.totalCount,
    required this.summaryText,
  });

  factory RegionSummaryModel.fromJson(Map<String, dynamic> json) {
    return RegionSummaryModel(
      regionPrimary: json['regionPrimary'] as String,
      firstCategory: json['firstCategory'] as String,
      totalCount: int.parse(json['totalCount'].toString()),
      summaryText: json['summaryText'] as String,
    );
  }
}
