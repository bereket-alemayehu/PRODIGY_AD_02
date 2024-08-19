import 'package:flutter/material.dart';
import 'package:simple_to_do_list/top_app_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
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
  List<Task> _textList = [];
  final TodoList _todoList = TodoList();

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(TaskAdapter());
  }

  void _loadTasks() async {
    final box = await Hive.openBox<Task>('tasks');
    _textList = box.values.toList();
    setState(() {});
  }

  void _saveTasks() async {
    final box = await Hive.openBox<Task>('tasks');
    box.putAll(_textList.asMap());
  }

  @override
  void initState() {
    super.initState();
    _initHive();
    _loadTasks();
  }

  void _editTask(int index) {
    String _newTaskText = _textList[index].text;
    final _textFieldController = TextEditingController(text: _newTaskText);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            controller: _textFieldController,
            onChanged: (value) {
              _newTaskText = value;
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _textList[index].text = _newTaskText;
                  _saveTasks();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                                      _saveTasks();
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
                                  _editTask(index);
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _todoList.deletedTasks.add(_textList[index]);
                                  _textList.removeAt(index);

                                  _todoList.uncompletedTasks.removeAt(index);
                                  _saveTasks();
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
                      _saveTasks();

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

class TaskAdapter extends TypeAdapter<Task> {
  @override
  int get typeId => 0;

  @override
  Task read(BinaryReader reader) {
    final text = reader.readString();
    return Task(text: text);
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeString(obj.text);
  }
}
