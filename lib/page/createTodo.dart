import 'package:flutter/material.dart';
import '../DataBaseHelper.dart';
import '../models/todo_model.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () async {
                  await DataBaseHelper.instance.insert(
                    Todo(
                      task: controller.text,
                      isCompleted: 0,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Add Task'))
            )
          ],
        ),
      )),
    );
  }
}
