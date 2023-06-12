// GENERATED CODE - DO NOT MODIFY BY HAND

part of '01_chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SqlChatAdapter extends TypeAdapter<SqlChat> {
  @override
  final int typeId = 0;

  @override
  SqlChat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SqlChat(
      userId: fields[0] as String,
      uniqueId: fields[1] as String,
      nickname: fields[2] as String,
      profilePictureUrl: fields[3] as String,
      comment: fields[4] as String,
      isSubscriber: fields[5] as String,
      followRole: fields[6] as String,
      createdAt: fields[7] as String,
      chatIdKey: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SqlChat obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.uniqueId)
      ..writeByte(2)
      ..write(obj.nickname)
      ..writeByte(3)
      ..write(obj.profilePictureUrl)
      ..writeByte(4)
      ..write(obj.comment)
      ..writeByte(5)
      ..write(obj.isSubscriber)
      ..writeByte(6)
      ..write(obj.followRole)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.chatIdKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SqlChatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
