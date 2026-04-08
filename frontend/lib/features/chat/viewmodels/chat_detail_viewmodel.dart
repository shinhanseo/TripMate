import 'package:flutter/foundation.dart';
import '../services/chat_api.dart';
import '../models/chat_detail_model.dart';

class ChatDetailViewModel extends ChangeNotifier {
  final ChatApi chatApi;

  ChatDetailViewModel({required this.chatApi});

  ChatDetailModel? chatDetail;
  bool isLoading = false;
  String? errorMessage;
  bool hasLoaded = false;

  Future<void> getChatDetail(int meetingId) async {
    if (isLoading) return;
    if (hasLoaded) return;

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await chatApi.getChatDetail(meetingId);

      chatDetail = result;
      hasLoaded = true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      chatDetail = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
