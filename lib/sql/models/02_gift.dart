// ignore_for_file: file_names

import 'package:hive/hive.dart';

part '02_gift.g.dart';

@HiveType(typeId: 1)
class SqlGift extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String uniqueId;

  @HiveField(2)
  final String nickname;

  @HiveField(3)
  final String profilePictureUrl;

  @HiveField(4)
  final String giftId;

  @HiveField(5)
  final String repeatCount;

  @HiveField(6)
  final String giftName;

  @HiveField(7)
  final String diamondCount;

  @HiveField(8)
  final String giftPictureUrl;

  @HiveField(9)
  final String giftIdKey;

  @HiveField(10)
  final String createdAt;

  SqlGift(
      {required this.userId,
      required this.uniqueId,
      required this.nickname,
      required this.profilePictureUrl,
      required this.giftId,
      required this.repeatCount,
      required this.giftName,
      required this.diamondCount,
      required this.giftPictureUrl,
      required this.giftIdKey,
      required this.createdAt});
}
