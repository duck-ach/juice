// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 1;

  @override
  Expense read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expense(
      id: fields[0] as String,
      amount: fields[1] as double,
      categoryId: fields[2] as String,
      date: fields[3] as DateTime,
      memo: fields[4] as String?,
      isFixed: fields[5] as bool,
      isIncome: fields[7] == null ? false : fields[7] as bool,
      createdAt: fields[6] as DateTime?,
      installmentMonths: fields[9] == null ? 1 : fields[9] as int,
      currentInstallmentIndex: fields[10] == null ? 1 : fields[10] as int,
      installmentGroupId: fields[11] as String?,
      cardId: fields[12] as String?,
    )..paymentMethodName =
        fields[8] == null ? 'checkCard' : fields[8] as String;
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.memo)
      ..writeByte(5)
      ..write(obj.isFixed)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.isIncome)
      ..writeByte(8)
      ..write(obj.paymentMethodName)
      ..writeByte(9)
      ..write(obj.installmentMonths)
      ..writeByte(10)
      ..write(obj.currentInstallmentIndex)
      ..writeByte(11)
      ..write(obj.installmentGroupId)
      ..writeByte(12)
      ..write(obj.cardId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
