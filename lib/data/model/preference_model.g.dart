// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreferenceAdapter extends TypeAdapter<Preference> {
  @override
  final int typeId = 0;

  @override
  Preference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Preference(
      apiId: fields[0] as int,
      customName: fields[1] as String,
      thumbnailUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Preference obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.apiId)
      ..writeByte(1)
      ..write(obj.customName)
      ..writeByte(2)
      ..write(obj.thumbnailUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
