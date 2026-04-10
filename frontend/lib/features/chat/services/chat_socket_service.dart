import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/chat_detail_model.dart';

class ChatSocketService {
  final String socketBaseUrl;

  IO.Socket? _socket;

  ChatSocketService({required this.socketBaseUrl});

  Future<void> connect({
    required String accessToken,
    required int meetingId,
    required void Function(MessageModel message) onNewMessage,
    required void Function(String message) onError,
  }) async {
    _socket?.dispose();

    _socket = IO.io(
      socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': accessToken})
          .build(),
    );

    _socket!.onConnect((_) {
      _socket!.emit('join_room', {'meetingId': meetingId});
    });

    _socket!.on('new_message', (data) {
      onNewMessage(_parseMessage(data));
    });

    _socket!.on('socket_error', (data) {
      onError(_parseErrorMessage(data));
    });

    _socket!.connect();
  }

  void sendMessage({required int meetingId, required String content}) {
    _socket?.emit('send_message', {
      'meetingId': meetingId,
      'content': content,
    });
  }

  void dispose() {
    _socket?.off('new_message');
    _socket?.off('socket_error');
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }

  MessageModel _parseMessage(dynamic data) {
    final map = Map<String, dynamic>.from(data as Map);
    return MessageModel.fromJson(map);
  }

  String _parseErrorMessage(dynamic data) {
    final map = Map<String, dynamic>.from(data as Map);
    return (map['message'] ?? 'socket error').toString();
  }
}
