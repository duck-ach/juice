// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_budget.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyBudgetAdapter extends TypeAdapter<WeeklyBudget> {
  @override
  final int typeId = 2;

  @override
  WeeklyBudget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyBudget(
      id: fields[0] as String,
      weekStartDate: fields[1] as DateTime,
      amount: fields[2] as double,
      createdAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyBudget obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.weekStartDate)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyBudgetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
