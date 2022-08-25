import 'package:doyoon/database/controllers/products_db_controller.dart';
import 'package:doyoon/models/process_response.dart';
import 'package:doyoon/models/product.dart';
import 'package:flutter/material.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> products = <Product>[];
  final ProductsDbController _dbController = ProductsDbController();

  Future<ProcessResponse> create(Product product) async {
    int newRowId = await _dbController.create(product);
    if (newRowId != 0) {
      product.id = newRowId;
      products.add(product);
      notifyListeners();
    }
    return getResponse(newRowId != 0);
  }

  void read() async {
    products = await _dbController.read(0);
    notifyListeners();
  }

  Future<ProcessResponse> update(Product product) async {
    bool updated = await _dbController.update(product);
    if (updated) {
      int index = products.indexWhere((element) => element.id == product.id);
      if (index != -1) {
        products[index] = product;
        notifyListeners();
      }
    }
    return getResponse(updated);
  }

  Future<ProcessResponse> delete (int index) async{
    bool deleted = await _dbController.delete(products[index].id);
    if(deleted){
      products.removeAt(index);
      notifyListeners();
    }
    return getResponse(deleted);
  }

  ProcessResponse getResponse(bool status) {
    return ProcessResponse(
        message: status ? 'Process Successful' : 'Process Fail',
        success: status);
  }
}
