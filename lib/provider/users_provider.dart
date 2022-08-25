import 'package:doyoon/database/controllers/users_db_controller.dart';
import 'package:doyoon/models/process_response.dart';
import 'package:doyoon/models/user.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {
  List<User> users = <User>[];
  final UsersDbController _dbController = UsersDbController();

  Future<ProcessResponse> create(User user) async {
    int newRowId = await _dbController.create(user);
    if (newRowId != 0) {
      user.id = newRowId;
      users.add(user);
      notifyListeners();
    }
    return getResponse(newRowId != 0);
  }

  void read() async {
    users = await _dbController.read(0);
    notifyListeners();
  }

  Future<ProcessResponse> update(User user) async {
    bool updated = await _dbController.update(user);
    if (updated) {
      int index = users.indexWhere((element) => element.id == user.id);
      if (index != -1) {
        users[index] = user;
        notifyListeners();
      }
    }
    return getResponse(updated);
  }

  Future<ProcessResponse> delete (int index) async{
    bool deleted = await _dbController.delete(users[index].id);
    if(deleted){
      users.removeAt(index);
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
