// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardItemAdapter extends TypeAdapter<CardItem> {
  @override
  final int typeId = 3;

  @override
  CardItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardItem(
      id: fields[0] as String,
      name: fields[1] as String,
      colorValue: fields[3] as int,
      excludeFromJuice: fields[4] == null ? false : fields[4] as bool?,
      isDefault: fields[5] as bool,
      orderIndex: fields[6] == null ? 0 : fields[6] as int,
    )..typeName = fields[2] == null ? 'check' : fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, CardItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.typeName)
      ..writeByte(3)
      ..write(obj.colorValue)
      ..writeByte(4)
      ..write(obj.excludeFromJuice)
      ..writeByte(5)
      ..write(obj.isDefault)
      ..writeByte(6)
      ..write(obj.orderIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
