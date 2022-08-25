import 'package:doyoon/database/db_operations.dart';
import 'package:doyoon/models/user.dart';

class UsersDbController extends DbOperations<User> {
  @override
  Future<int> create(User model) async {
    return await database.insert(User.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    int deletedRowsCount = await database
        .delete(User.tableName, where: 'id = ?', whereArgs: [id]);
    return deletedRowsCount == 1;
  }

  @override
  Future<List<User>> read(int id) async {
    List<Map<String, dynamic>> rowsMap =
    await database.query(User.tableName);
    List<User> users =
    rowsMap.map((rowMap) => User.fromMap(rowMap)).toList();
    return users;
  }

  @override
  Future<User?> show(int id) async {
    List<Map<String, dynamic>> rowsMap = await database
        .query(User.tableName, where: 'id = ?', whereArgs: [id]);
    return rowsMap.isNotEmpty ? User.fromMap(rowsMap.first) : null;
  }

  @override
  Future<bool> update(User model) async {
    int updatedRowsCount = await database.update(
        User.tableName, model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
    return updatedRowsCount == 1;
  }
}
