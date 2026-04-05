import 'package:flutter/foundation.dart';
import '../models/total_meeting_map_model.dart';
import '../services/mypage_api.dart';

class TotalMeetingMapViewModel extends ChangeNotifier {
  final MyPageApi myPageApi;

  TotalMeetingMapViewModel({required this.myPageApi});

  List<TotalMeetingMapModel> totalMeetingMap = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getTotalMeetingMap() async {
    try {
      if (isLoading) return;

      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await myPageApi.getTotalMeetingMap();

      totalMeetingMap = result;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      totalMeetingMap = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
