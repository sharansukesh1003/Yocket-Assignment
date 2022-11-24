// ignore_for_file: await_only_futures
import 'dart:convert';
import 'package:todo/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoDatabase {
  static Future getTodoList() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var todos = await sharedPreferences.getKeys().toList();
    return todos;
  }

  static Future<void> addTodo(
      {required String id, required TodoModel todo}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(id, json.encode(todo));
  }

  static Future getTodo({required String key}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var todo = await sharedPreferences.get(key).toString();
    return json.decode(todo);
  }

  static Future<void> deleteAll() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static updateTodoDuration(
      {required String id, required TodoModel todo}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(id, json.encode(todo));
  }
}
