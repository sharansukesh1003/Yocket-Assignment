import '../models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  final List<TodoModel> _list = [];

  List<TodoModel> get list => _list;

  void addListItem(TodoModel task) {
    list.add(task);
    notifyListeners();
  }

  void updateListItem(int index, TodoModel todo) {
    list[index] = todo;
    notifyListeners();
  }
}
