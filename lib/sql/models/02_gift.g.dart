// GENERATED CODE - DO NOT MODIFY BY HAND

part of '02_gift.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SqlGiftAdapter extends TypeAdapter<SqlGift> {
  @override
  final int typeId = 1;

  @override
  SqlGift read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SqlGift(
      userId: fields[0] as String,
      uniqueId: fields[1] as String,
      nickname: fields[2] as String,
      profilePictureUrl: fields[3] as String,
      giftId: fields[4] as String,
      repeatCount: fields[5] as String,
      giftName: fields[6] as String,
      diamondCount: fields[7] as String,
      giftPictureUrl: fields[8] as String,
      giftIdKey: fields[9] as String,
      createdAt: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SqlGift obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.uniqueId)
      ..writeByte(2)
      ..write(obj.nickname)
      ..writeByte(3)
      ..write(obj.profilePictureUrl)
      ..writeByte(4)
      ..write(obj.giftId)
      ..writeByte(5)
      ..write(obj.repeatCount)
      ..writeByte(6)
      ..write(obj.giftName)
      ..writeByte(7)
      ..write(obj.diamondCount)
      ..writeByte(8)
      ..write(obj.giftPictureUrl)
      ..writeByte(9)
      ..write(obj.giftIdKey)
      ..writeByte(10)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SqlGiftAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
