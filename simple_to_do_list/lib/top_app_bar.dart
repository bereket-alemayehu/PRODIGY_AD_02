import 'package:flutter/material.dart';
import 'todo_list_app.dart';
import 'deleted_tasks.dart';
import 'completed_tasks.dart';
import 'uncompleted_tasks.dart';

class TodoList {
  List<Task> _tasks = [];
  List<Task> _completedTasks = [];
  List<Task> _deletedTasks = [];
  List<Task> _uncompletedTasks = [];

  // void addTask(Task task) {
  //   _tasks.add(task);
  // }

  // void deleteTask(Task task) {
  //   _tasks.remove(task);
  //   _completedTasks.add(task);
  // }

  List<Task> get tasks => _tasks;
  List<Task> get completedTasks => _completedTasks;
  List<Task> get deletedTasks => _deletedTasks;
  List<Task> get uncompletedTasks => _uncompletedTasks;
}

class TopAppBar extends StatefulWidget {
  final TodoList todoList;

  const TopAppBar({super.key, required this.todoList});
  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  String item1 = "Deleted Tasks";
  String item2 = "Completed Tasks";
  String item3 = "Uncompleted Tasks";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60),
      color: const Color.fromARGB(255, 14, 124, 134),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          DropdownButton<String>(
            style: const TextStyle(
                color: Color.fromARGB(255, 186, 186, 186),
                fontSize: 14,
                fontWeight: FontWeight.bold),
            value: 'Default  ',
            items: <String>['Default  '].map(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (String? newValue) {
              setState(() {
                // value = newValue;
              });
            },
          ),
          const Spacer(),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.delete_forever_outlined),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      item1,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                value: item1,
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.done_all),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      item2,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                value: item2,
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.question_mark),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      item3,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                value: item3,
              ),
            ],
            onSelected: (String? newValue) {
              if (newValue == item2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CompletedTasks(widget.todoList.completedTasks),
                  ),
                );
              } else if (newValue == item1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DeletedTasks(widget.todoList.deletedTasks),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UncompletedTasks(
                      widget.todoList,
                      uncompletedTasks: widget.todoList.uncompletedTasks,
                    ),
                  ),
                );
              }

              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
