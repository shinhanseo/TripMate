import 'package:flutter/foundation.dart';
import '../models/region_summary_model.dart';
import '../services/region_summary_api.dart';

class RegionSummaryViewModel extends ChangeNotifier {
  final HomeRegionSummaryApi regionSummaryApi;

  RegionSummaryViewModel({required this.regionSummaryApi});

  List<RegionSummaryModel> regionSummaries = [];
  bool isLoading = false;
  String? errorMessage;
  bool _hasLoaded = false;

  Future<void> loadRegionSummary() async {
    if (_hasLoaded || isLoading) return;

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final List<RegionSummaryModel> result = await regionSummaryApi
          .fetchRegionSummaryList();

      regionSummaries = result;
      _hasLoaded = true;
    } catch (e) {
      errorMessage = '동행 요약 정보를 불러오지 못했습니다.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
