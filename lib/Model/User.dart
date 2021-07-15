import 'package:moor/moor.dart';

enum Role {
  Admin,
  User,
}

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 1, max: 50)();
  TextColumn get password => text().withLength(min: 1, max: 150)();
  IntColumn get role =>
      intEnum<Role>().withDefault(Constant(Role.User.index))();
}
