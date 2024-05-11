part of '../api_db.dart';

@DataClassName('ProfilesCloudsDto')
class ProfilesCloudsTable extends Table {
  @override
  String get tableName => 'profile_clouds';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get idProfile => integer()();
  TextColumn get titleLink => text().unique().withLength(min: 2, max: 64)();
  TextColumn get cloudType => text().withLength(min: 2, max: 16)();
  TextColumn get password => text().nullable().withLength(min: 0, max: 64)();
  TextColumn get link => text().withDefault(Constant(const Uuid().v1()))();
  BoolColumn get state => boolean().withDefault(const Constant(true))();
}
