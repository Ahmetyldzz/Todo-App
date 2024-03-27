import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_app/todo_app/constants/colors.dart';
import 'package:todo_app/todo_app/model/todo.dart';
import 'package:todo_app/todo_app/screens/home_page.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onDoChanged,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank_rounded,
          color: ProjectColors().commonTheme,
        ),
        title: Text(
          todo.toDoText ?? "",
          style: TextStyle(
              fontSize: 16,
              color: ProjectColors().black,
              decoration: todo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        trailing: Container(
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            iconSize: 18,
            icon: const Icon(Icons.delete),
            color: Colors.white,
            onPressed: () {
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
