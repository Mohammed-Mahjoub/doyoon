import 'package:doyoon/database/db_operations.dart';
import 'package:doyoon/models/order.dart';
import 'package:doyoon/models/user.dart';

class OrdersDbController extends DbOperations<Order> {

  @override
  Future<int> create(Order model) async {
    return await database.insert(Order.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    int deletedRowsCount = await database
        .delete(Order.tableName, where: 'id = ?', whereArgs: [id]);
    return deletedRowsCount == 1;
  }

  @override
  Future<List<Order>> read(int id) async {
    // List<Map<String, dynamic>> rowsMap =
    // await database.query(Order.tableName,where: 'user_id = ?',whereArgs: [id]);
    List<Map<String, dynamic>> rowsMap = await database.rawQuery('''
    SELECT orders.id, orders.product_id, orders.user_id, orders.quantity, orders.order_time, products.name as product_name, products.price as product_price
    FROM orders JOIN products ON orders.product_id = products.id
    WHERE orders.user_id = ?
    ''',[id]);
    List<Order> orders =
    rowsMap.map((rowMap) => Order.fromMap(rowMap)).toList();
    return orders;
  }

  @override
  Future<Order?> show(int id) async {
    List<Map<String, dynamic>> rowsMap = await database
        .query(User.tableName, where: 'id = ?', whereArgs: [id]);
    return rowsMap.isNotEmpty ? Order.fromMap(rowsMap.first) : null;
  }

  @override
  Future<bool> update(Order model) async {
    int updatedRowsCount = await database.update(
        Order.tableName, model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
    return updatedRowsCount == 1;
  }
}
