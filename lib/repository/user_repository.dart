import 'dart:async';
import 'package:ecoinclution_proyect/models/auth/api_model.dart';
import 'package:ecoinclution_proyect/models/auth/user_model.dart';
import 'package:meta/meta.dart';
import 'package:ecoinclution_proyect/api_connection/auth/api_connection.dart';
import 'package:ecoinclution_proyect/dao/user_dao.dart';

class UserRepository {
  final userDao = UserDao();
  Future<Map<String,dynamic>> registerUser({
    String username = "",
    String email = "",
    String firstName = "",
    String lastName = "",
    String password = "",
    String password2 = "",
  }) async {
    UserRegister userRegister = UserRegister(username: username, email: email, firstName: firstName, lastName: lastName, password: password, password2: password2);
    Map<String,dynamic> map = await postUser(userRegister);
    return map;
  }

  Future<User> authenticateUser({
    String username = "",
    String password = "",
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getToken(userLogin);
    User user = User(
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken({@required User? user}) async {
    // write token with the user to the database
    int result = await userDao.createUser(user!);
    print("id $result created");
  }
  Future<void> updateUser({@required User? user}) async {
    // write token with the user to the database
    int result = await userDao.updateUser(user!);
    print(user.toDatabaseJson());
    print("id $result updated");
  }

  Future<void> deleteToken({@required int? id}) async {
    int result = await userDao.deleteUser(id);
    print("id $result deleted");
  }

  Future<bool> hasToken({@required int? id}) async {
    bool result = await userDao.checkUser(id);
    return result;
  }

  Future<User> getUser({@required int? id}) async {
    Map<String, dynamic> map = await userDao.selectUser(id);
    User user = User.fromDatabaseJson(map);
    return user;
  }
}
