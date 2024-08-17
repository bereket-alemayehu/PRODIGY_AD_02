import 'package:flutter/material.dart';
import 'todo_list_app.dart';
import 'top_app_bar.dart';

class UncompletedTasks extends StatefulWidget {
  final TodoList todoList;
  final List<Task> uncompletedTasks;

  UncompletedTasks(this.todoList, {required this.uncompletedTasks});
  @override
  State<UncompletedTasks> createState() {
    return _UncompletedTasksState();
  }
}

class _UncompletedTasksState extends State<UncompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 124, 134),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Uncompleted Tasks',
          style: TextStyle(color: Colors.amberAccent),
        ),
        backgroundColor: const Color.fromARGB(255, 14, 124, 134),
      ),
      body: widget.uncompletedTasks.isEmpty
          ? Center(
              child: Text(
                "No Uncompleted Tasks",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: widget.uncompletedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.question_mark,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Text(
                        widget.uncompletedTasks[index].text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
