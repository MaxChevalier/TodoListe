import 'package:flutter/material.dart';
import '../DataBaseHelper.dart';
import '../models/todo_model.dart';
import '../Widget/ToDoTaskWidget.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        body: FutureBuilder(
          future: DataBaseHelper.instance.getAllTodos(),
          builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            }

            List<Todo> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ToDoTaskWidget(
                    todo: data[index], reload: reload);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/createTodo');
            setState(() {});
          },
          child: const Icon(Icons.add),
        ));
  }

  void reload() {
    setState(() {});
  }
}
