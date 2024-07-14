import 'package:flutter/material.dart';

enum ToDoPriority { Low, Normal, High }

class MyTodo {
  int id;
  String name;
  ToDoPriority priority;
  bool completed;

  MyTodo(
      {required this.id,
      required this.name,
      required this.priority,
      this.completed = false});

  static List<MyTodo> todos = [];
}

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final _controller = TextEditingController();
  ToDoPriority priority = ToDoPriority.Normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDoApp",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: MyTodo.todos.isEmpty
          ? Center(
              child: Text(
              "Nothing to show here!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                final todo = MyTodo.todos[index];
                return TodoItem(
                    todo: todo,
                    onChanged: (value) {
                      setState(() {
                        MyTodo.todos[index].completed = value;
                      });
                    });
              },
              itemCount: MyTodo.todos.length,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
        onPressed: () {
          addTodo();
          // showModalBottomSheet(context: context, builder: (context) => BottomSheet(onClosing: () => , builder: (context) => ,),);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void addTodo() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setBuilderState) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      width: 400,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: 'What to do?',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(26))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Select Priority"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<ToDoPriority>(
                            value: ToDoPriority.Low,
                            groupValue: priority,
                            onChanged: (value) {
                              setBuilderState(() {
                                priority = value!;
                              });
                            }),
                        Text(ToDoPriority.Low.name),
                        Radio<ToDoPriority>(
                            value: ToDoPriority.Normal,
                            groupValue: priority,
                            onChanged: (value) {
                              setBuilderState(() {
                                priority = value!;
                              });
                            }),
                        Text(ToDoPriority.Normal.name),
                        Radio<ToDoPriority>(
                            value: ToDoPriority.High,
                            groupValue: priority,
                            onChanged: (value) {
                              setBuilderState(() {
                                priority = value!;
                              });
                            }),
                        Text(ToDoPriority.High.name),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 12.0),
                        height: 60,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: _save,
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.purple)),
                        ))
                  ],
                ),
              ),
            ));
  }

  void _save() {
    if (_controller.text.isEmpty) {
      showMsg(context, 'Input Field must not be empty');
      return;
    }
    final todo = MyTodo(
        id: DateTime.now().microsecondsSinceEpoch,
        name: _controller.text,
        priority: priority);

    MyTodo.todos.add(todo);
    _controller.clear();
    setState(() {

    });
    Navigator.pop(context);
  }
}

void showMsg(BuildContext context, String s) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Caution!"),
            content: Text(s),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("Close"))
            ],
          ));
}

class TodoItem extends StatelessWidget {
  final MyTodo todo;
  final Function(bool) onChanged;

  const TodoItem({super.key, required this.todo, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: todo.completed,
      onChanged: (value) {
        onChanged(value!);
      },
      title: Text(todo.name),
      subtitle: Text("Priority : ${todo.priority.name}"),
    );
  }
}
