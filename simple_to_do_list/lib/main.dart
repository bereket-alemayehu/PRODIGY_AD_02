import 'package:flutter/material.dart';
import 'package:simple_to_do_list/todo_list_app.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        checkboxTheme: CheckboxThemeData(
          side: BorderSide(width: 2.0, color: Colors.white),
        ),
      ),
      home: TodoListApp(),
    ),
  );
}
