import 'package:flutter/material.dart';

import 'todo_list_app.dart';

class DeletedTasks extends StatefulWidget {
  final List<Task> _deletedTasks;

  DeletedTasks(this._deletedTasks);
  @override
  State<DeletedTasks> createState() => _DeletedTasksState();
}

class _DeletedTasksState extends State<DeletedTasks> {
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
          "Deleted Tasks",
          style: TextStyle(color: Colors.amberAccent),
        ),
      ),
      body: widget._deletedTasks.isEmpty
          ? Center(
              child: Text(
              "No Deleted Tasks",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ))
          : ListView.builder(
              itemCount: widget._deletedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            widget._deletedTasks.removeAt(index);
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget._deletedTasks[index].text,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ));
              }),
    );
  }
}
