import 'package:flutter/material.dart';
import 'package:simple_to_do_list/top_app_bar.dart';
// import 'uncompleted_tasks.dart';

class TodoListApp extends StatefulWidget {
  const TodoListApp({super.key});
  @override
  State<TodoListApp> createState() => _TodoListAppState();
}

class Task {
  String text;
  bool isChecked;
  bool isCompleted;
  Task({required this.text, this.isChecked = false, this.isCompleted = false});
}

class _TodoListAppState extends State<TodoListApp> {
  final TodoList _todoList = TodoList();

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  List<Task> _textList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 124, 134),
      body: Column(
        children: [
          TopAppBar(
            todoList: _todoList,
          ),
          // _textList.isEmpty
          //     ?
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _textList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Checkbox(
                                value: _textList[index].isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _textList[index].isChecked = value!;
                                    if (value) {
                                      _todoList.completedTasks
                                          .add(_textList[index]);
                                      _textList.removeAt(index);
                                      _todoList.uncompletedTasks
                                          .removeAt(index);
                                    }
                                  });
                                }),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _textList[index].text,
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 18),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _todoList.deletedTasks.add(_textList[index]);
                                  _textList.removeAt(index);

                                  _todoList.uncompletedTasks.removeAt(index);
                                });
                              },
                              icon: Icon(
                                Icons.cancel_presentation,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          _textList.isEmpty
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book_outlined,
                        color: const Color.fromARGB(255, 234, 194, 194),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Text(
                        //  MainAxisAlignment:MainAxisAlignment.center,
                        'No Tasks yet',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 234, 194, 194),
                            fontSize: 24),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 10,
                ),
          // Add the TextField
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.deepPurple),
                    onPressed: () {
                      _textList.add(Task(text: _textController.text));

                      _todoList.uncompletedTasks
                          .add(Task(text: _textController.text));

                      setState(() {});
                      _textController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          (50),
                        ),
                      ),
                      minimumSize: const Size(60, 60),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _textController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      // border: OutlineInputBorder(
                      //     // borderSide: BorderSide(color: Colors.red, width: 2.0),
                      //     // borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 191, 190, 190),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 191, 190, 190),
                            width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Enter Quick Tasks Here',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
