import 'package:hai_noob/Model/User.dart';
import 'package:moor/moor.dart';
import '../DB/Database.dart';
import '../App/Config.dart';

part 'UserDAO.g.dart';

@UseDao(tables: [Users])
class UserDAO extends DatabaseAccessor<AppDatabase> with _$UserDAOMixin {
  $UsersTable? table;

  UserDAO(AppDatabase db) : super(db) {
    table = db.users;
  }

  Future<List<User>> listAllUser() async {
    return select(table!).get();
  }

  Future<User?> findUserByUsername(String usernamename) async {
    return (select(table!)..where((tbl) => tbl.username.equals(usernamename)))
        .getSingleOrNull();
  }

  Future<void> createAdminAccount() async {
    await into(table!).insert(UsersCompanion.insert(
        username: 'admin',
        password: AppConfig.DEFAULT_ADMIN_PASSWORD,
        role: Value(Role.Admin)));

    return;
  }
}
