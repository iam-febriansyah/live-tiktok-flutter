// ignore_for_comment: comment_names

// ignore_for_file: file_names

import 'package:hive/hive.dart';

part '01_chat.g.dart';

@HiveType(typeId: 0)
class SqlChat extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String uniqueId;

  @HiveField(2)
  final String nickname;

  @HiveField(3)
  final String profilePictureUrl;

  @HiveField(4)
  final String comment;

  @HiveField(5)
  final String isSubscriber;

  @HiveField(6)
  final String followRole;

  @HiveField(7)
  final String createdAt;

  @HiveField(8)
  final String chatIdKey;

  SqlChat(
      {required this.userId,
      required this.uniqueId,
      required this.nickname,
      required this.profilePictureUrl,
      required this.comment,
      required this.isSubscriber,
      required this.followRole,
      required this.createdAt,
      required this.chatIdKey});
}
