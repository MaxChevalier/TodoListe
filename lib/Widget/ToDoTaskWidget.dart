import 'package:flutter/material.dart';
import 'package:todo_app_sqlite_freezed/models/todo_model.dart';
import '../DataBaseHelper.dart';

class ToDoTaskWidget extends StatelessWidget {
  final Todo todo;
  Function reload;

  ToDoTaskWidget({required this.todo, required this.reload});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(2.5),
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFC07CC0)),
                left: BorderSide(color: Color(0xFFC07CC0)),
                right: BorderSide(color: Color(0xFFC07CC0)),
                bottom: BorderSide(color: Color(0xFFC07CC0)),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Color.fromARGB(255, 255, 237, 255),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.5),
              child: Row(
                children: [
                  CheckTodo(todo: todo),
                  Expanded(
                    child: Text(
                      todo.task,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        removetask();
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            )));
  }

  void removetask() {
    DataBaseHelper.instance.delete(todo.id ?? 0);
    reload();
  }
}

class CheckTodo extends StatefulWidget {
  final Todo todo;

  const CheckTodo({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<CheckTodo> createState() => _CheckTodoState();
}

class _CheckTodoState extends State<CheckTodo> {
  Todo get todo => widget.todo;
  bool status = false;

  @override
  void initState() {
    super.initState();
    status = todo.isCompleted == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: status,
        onChanged: (value) {
          DataBaseHelper.instance.update(
            Todo(
              id: todo.id,
              task: todo.task,
              isCompleted: value! ? 1 : 0,
            ),
          );
          setState(() {
            status = value!;
          });
        });
  }
}
