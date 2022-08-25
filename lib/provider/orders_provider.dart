import 'package:doyoon/database/controllers/orders_db_controller.dart';
import 'package:doyoon/models/process_response.dart';
import 'package:doyoon/models/order.dart';
import 'package:flutter/material.dart';

class OrdersProvider extends ChangeNotifier {
  List<Order> orders = <Order>[];
  final OrdersDbController _dbController = OrdersDbController();

  Future<ProcessResponse> create(Order order) async {
    int newRowId = await _dbController.create(order);
    if (newRowId != 0) {
      order.id = newRowId;
      orders.add(order);
      notifyListeners();
    }
    return getResponse(newRowId != 0);
  }

  Future<List<Order>> read(int id) async {
    orders = await _dbController.read(id);
    notifyListeners();
    return orders;
  }

  Future<ProcessResponse> update(Order order) async {
    bool updated = await _dbController.update(order);
    if (updated) {
      int index = orders.indexWhere((element) => element.id == order.id);
      if (index != -1) {
        orders[index] = order;
        notifyListeners();
      }
    }
    return getResponse(updated);
  }

  Future<ProcessResponse> changeQuantity(int index, int count) async{
    bool isDeleted = count == 0;
    Order order = orders[index];
    bool result = isDeleted ? await _dbController.delete(order.id) : await _dbController.update(order);
    if(result){
      if(isDeleted){
        orders.removeAt(index);
      }
      else{
        order.quantity = count;
        orders[index] = order;
      }
      notifyListeners();
    }
    return getResponse(result);
  }

  Future<ProcessResponse> delete (int index) async{
    bool deleted = await _dbController.delete(orders[index].id);
    if(deleted){
      orders.removeAt(index);
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
