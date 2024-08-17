import 'package:flutter/material.dart';
import 'todo_list_app.dart';

class CompletedTasks extends StatefulWidget {
  final List<Task> _completedTasks;

  @override
  CompletedTasks(this._completedTasks);
  State<CompletedTasks> createState() => _CompletedTasks();
}

class _CompletedTasks extends State<CompletedTasks> {
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
        backgroundColor: const Color.fromARGB(255, 14, 124, 134),
        title: Text(
          'Completed Tasks',
          style: TextStyle(color: Colors.amberAccent),
        ),
      ),
      body: widget._completedTasks.isEmpty
          ? Center(
              child: Text(
              "No Completed Tasks",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ))
          : ListView.builder(
              itemCount: widget._completedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.done_all,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        widget._completedTasks[index].text,
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(
                            () {
                              widget._completedTasks.removeAt(index);
                            },
                          );
                        },
                        icon: Icon(
                          Icons.cleaning_services,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
