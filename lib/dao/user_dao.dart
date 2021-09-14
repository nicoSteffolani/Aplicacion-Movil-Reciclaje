import 'package:ecoinclution_proyect/database/user_database.dart';
import 'package:ecoinclution_proyect/model/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());
    print(result);
    return result;
  }

  Future<int> deleteUser(int? id) async {
    final db = await dbProvider.database;
    var result = await db
        .delete(userTable);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users = await db
          .query(userTable);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
  Future<Map<String,dynamic>> selectUser(int id) async {
    final db = await dbProvider.database;
    try {
      List<Map<String,dynamic>> users = await db
          .query(userTable);
      Map<String,dynamic> map = Map();
      print(users);
      users.forEach((row) {
        map = row;

      });

      return map;
    } catch (error) {
      throw Exception(error);

    }
  }
}
