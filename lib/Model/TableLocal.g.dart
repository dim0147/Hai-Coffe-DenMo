// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TableLocal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TableStatusAdapter extends TypeAdapter<TableStatus> {
  @override
  final int typeId = 4;

  @override
  TableStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TableStatus.Empty;
      case 1:
        return TableStatus.Holding;
      default:
        return TableStatus.Empty;
    }
  }

  @override
  void write(BinaryWriter writer, TableStatus obj) {
    switch (obj) {
      case TableStatus.Empty:
        writer.writeByte(0);
        break;
      case TableStatus.Holding:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TableLocalAdapter extends TypeAdapter<TableLocal> {
  @override
  final int typeId = 5;

  @override
  TableLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TableLocal(
      id: fields[0] as int,
      name: fields[1] as String,
      order: fields[2] as int,
      status: fields[3] as TableStatus,
      cart: fields[4] as Cart?,
    );
  }

  @override
  void write(BinaryWriter writer, TableLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.order)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.cart);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
