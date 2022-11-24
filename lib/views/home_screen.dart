// ignore_for_file: use_build_context_synchronously
import '../models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../providers/toggle_view_provider.dart';
import 'package:todo/database/todo_database.dart';
import 'package:todo/widgets/add_todo_widget.dart';
import 'package:todo/constants/constant_colors.dart';
import 'package:todo/widgets/grid_to_list_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getTodosFromDB();
    super.initState();
  }

  getTodosFromDB() async {
    List<String> todos = await TodoDatabase.getTodoList();
    List todosList = [];
    for (var i = 0; i < todos.length; i++) {
      todosList.add(await TodoDatabase.getTodo(key: todos[i]));
    }
    for (var j = 0; j < todosList.length; j++) {
      Provider.of<TodoProvider>(context, listen: false)
          .addListItem(TodoModel.fromJson(todosList[j]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ConstantColors.primaryColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: (() async {
            // TodoDatabase.deleteAll();
            AddTODOWidget addTODOWidget = AddTODOWidget();
            addTODOWidget.bootomSheetWidget(context);
          }),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Todo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Provider.of<ToggleViewProvider>(context, listen: false)
                    .changeView();
              },
              icon: Icon(
                Provider.of<ToggleViewProvider>(context).toggle
                    ? Icons.list_alt
                    : Icons.grid_on,
                size: Provider.of<ToggleViewProvider>(context).toggle ? 30 : 28,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<TodoProvider>(
            builder: (builder, todoProvider, _) {
              if (todoProvider.list.isEmpty) {
                return const Center(
                  child: Text(
                    "You have no todo's left.",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return TodoGridViewWidget(todoProvider: todoProvider);
              }
            },
          ),
        ),
      ),
    );
  }
}
