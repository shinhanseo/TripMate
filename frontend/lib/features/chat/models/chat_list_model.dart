class ChatListModel {
  final int roomId;
  final int meetingId;
  final String meetingTitle;
  final String placeText;
  final DateTime scheduledAt;
  final String meetingStatus;
  final DateTime chatJoinedAt;
  final DateTime roomCreatedAt;
  final DateTime roomUpdatedAt;
  final int? lastMessageId;
  final int? lastMessageSenderId;
  final String? lastMessageSenderNickname;
  final String? lastMessageContent;
  final DateTime? lastMessageCreatedAt;

  ChatListModel({
    required this.roomId,
    required this.meetingId,
    required this.meetingTitle,
    required this.placeText,
    required this.scheduledAt,
    required this.meetingStatus,
    required this.chatJoinedAt,
    required this.roomCreatedAt,
    required this.roomUpdatedAt,
    this.lastMessageId,
    this.lastMessageSenderId,
    this.lastMessageSenderNickname,
    this.lastMessageContent,
    this.lastMessageCreatedAt,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      roomId: int.parse(json['roomId'].toString()),
      meetingId: int.parse(json['meetingId'].toString()),
      meetingTitle: json['meetingTitle'] as String,
      placeText: json['placeText'] as String,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      meetingStatus: json['meetingStatus'] as String,
      chatJoinedAt: DateTime.parse(json['chatJoinedAt'] as String),
      roomCreatedAt: DateTime.parse(json['roomCreatedAt'] as String),
      roomUpdatedAt: DateTime.parse(json['roomUpdatedAt'] as String),
      lastMessageId: json['lastMessageId'] == null
          ? null
          : int.parse(json['lastMessageId'].toString()),
      lastMessageSenderId: json['lastMessageSenderId'] == null
          ? null
          : int.parse(json['lastMessageSenderId'].toString()),
      lastMessageSenderNickname: json['lastMessageSenderNickname'] as String?,
      lastMessageContent: json['lastMessageContent'] as String?,
      lastMessageCreatedAt: json['lastMessageCreatedAt'] == null
          ? null
          : DateTime.parse(json['lastMessageCreatedAt'] as String),
    );
  }
}
