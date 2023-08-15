import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Task {
  final String name;
  bool isCompleted;

  Task(this.name, this.isCompleted);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const TodoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].name),
            leading: Checkbox(
              value: tasks[index].isCompleted,
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    tasks[index].isCompleted = value;
                  });
                }
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  tasks.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await showDialog<Task>(
            context: context,
            builder: (BuildContext context) {
              String taskName = '';
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  onChanged: (value) {
                    taskName = value;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () {
                      if (taskName.isNotEmpty) {
                        Navigator.of(context).pop(Task(taskName, false));
                      }
                    },
                  ),
                ],
              );
            },
          );
          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
