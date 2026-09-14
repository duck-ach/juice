// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juice_saving_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JuiceSavingHistoryAdapter extends TypeAdapter<JuiceSavingHistory> {
  @override
  final int typeId = 4;

  @override
  JuiceSavingHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JuiceSavingHistory(
      id: fields[0] as String,
      periodType: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
      targetAmount: fields[4] as double,
      themeEmoji: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JuiceSavingHistory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.periodType)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.targetAmount)
      ..writeByte(5)
      ..write(obj.themeEmoji);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JuiceSavingHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
