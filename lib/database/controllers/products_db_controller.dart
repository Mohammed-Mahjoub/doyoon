import 'package:doyoon/database/db_operations.dart';
import 'package:doyoon/models/product.dart';

class ProductsDbController extends DbOperations<Product> {
  @override
  Future<int> create(Product model) async {
    return await database.insert(Product.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    int deletedRowsCount = await database
        .delete(Product.tableName, where: 'id = ?', whereArgs: [id]);
    return deletedRowsCount == 1;
  }

  @override
  Future<List<Product>> read(int id) async {
    List<Map<String, dynamic>> rowsMap =
        await database.query(Product.tableName);
    List<Product> products =
        rowsMap.map((rowMap) => Product.fromMap(rowMap)).toList();
    return products;
  }

  @override
  Future<Product?> show(int id) async {
    List<Map<String, dynamic>> rowsMap = await database
        .query(Product.tableName, where: 'id = ?', whereArgs: [id]);
    return rowsMap.isNotEmpty ? Product.fromMap(rowsMap.first) : null;
  }

  @override
  Future<bool> update(Product model) async {
    int updatedRowsCount = await database.update(
        Product.tableName, model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
    return updatedRowsCount == 1;
  }
}
