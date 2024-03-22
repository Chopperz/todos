// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteHiveTypeAdapter extends TypeAdapter<FavoriteHiveType> {
  @override
  final int typeId = 1;

  @override
  FavoriteHiveType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteHiveType(
      id: fields[0] as int?,
      name: fields[1] as String?,
      order: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteHiveType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteHiveTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
