import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/views/splash_screen.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/providers/toggle_view_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => ToggleViewProvider()),
      ],
      child: MaterialApp(
        title: 'Yocket Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        home: const SplashScreen(),
      ),
    );
  }
}
