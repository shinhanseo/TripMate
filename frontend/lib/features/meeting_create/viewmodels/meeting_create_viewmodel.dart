import 'package:flutter/foundation.dart';
import '../models/meeting_create_model.dart';
import '../../home_more/services/meeting_api.dart';

class MeetingCreateViewModel extends ChangeNotifier {
  final MeetingApi meetingApi;

  MeetingCreateViewModel({required this.meetingApi});

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;

  Future<void> createMeeting(MeetingCreateModel meeting) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await meetingApi.createMeeting(meeting: meeting);

      isSuccess = true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      isSuccess = false;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  void reset() {
    isLoading = false;
    errorMessage = null;
    isSuccess = false;
    notifyListeners();
  }
}
