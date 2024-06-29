import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> todoitem = [];
  void addItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        todoitem.add(task);
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      todoitem.removeAt(index);
    });
  }

  void prompttodoItem() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New Task'),
            content: TextField(
              autofocus: true,
              onSubmitted: (val) {
                addItem(val);
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  Widget _buildtodolist() {
    return ListView.builder(
      itemCount: todoitem.length,
      itemBuilder: (context, index) {
        return _buildtodoItem(todoitem[index], index);
      },
    );
  }

  Widget _buildtodoItem(String task, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(task),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => {
            removeItem(index),
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: Text('To Do App'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: _buildtodolist(),
      floatingActionButton: FloatingActionButton(
        onPressed: prompttodoItem,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
