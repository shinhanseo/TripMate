import 'package:flutter/foundation.dart';
import '../../home_more/models/meeting_model.dart';
import '../services/mypage_api.dart';

enum MyMeetingType { total, host, ing }

class MyMeetingViewModel extends ChangeNotifier {
  final MyPageApi myPageApi;
  final MyMeetingType type;
  MyMeetingViewModel({required this.myPageApi, required this.type});

  MeetingListModel? totalList;
  MeetingListModel? hostList;
  MeetingListModel? ingList;

  bool isLoading = false;
  String? errorMessage;
  bool isSuccess = false;

  Future<void> loadTotalMeeting() async {
    if (isLoading) return;

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await myPageApi.getTotalMeetings();

      totalList = result;
      isSuccess = true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception : ', '');
      isSuccess = false;
      totalList = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadHostMeeting() async {
    if (isLoading) return;

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await myPageApi.getHostMeetings();

      hostList = result;
      isSuccess = true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception : ', '');
      isSuccess = false;
      hostList = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadIngMeeting() async {
    if (isLoading) return;

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await myPageApi.getTotalMeetings();

      ingList = result;
      isSuccess = true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception : ', '');
      isSuccess = false;
      ingList = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
