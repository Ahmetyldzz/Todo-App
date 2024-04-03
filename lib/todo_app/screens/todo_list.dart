import 'package:flutter/material.dart';
import 'package:todo_app/todo_app/model/todo.dart';
import 'package:todo_app/todo_app/model/todo_database_provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
    todoDatabaseProvider = TodoDatabaseProvider();
    todoDatabaseProvider?.open();
  }

  Future<void> saveModel() async {
    final result = await todoDatabaseProvider?.insert(todoModel);
    print(result);
  }

  TodoDatabaseProvider? todoDatabaseProvider;
  TodoModel todoModel = TodoModel();
  List<TodoModel> todoList = [];

  Future getTodoList() async {
    todoList = (await todoDatabaseProvider?.getList())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(todoModel.toDoText);
          saveModel();
          getTodoList();
        },
      ),
      body: Card(
        elevation: 10,
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Expanded(child: buildWrapMethod()),
              Flexible(
                child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        todoList[index].toDoText.toString(),
                      ),
                      subtitle: Text(todoList[index].id.toString()),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Wrap buildWrapMethod() {
    return Wrap(
      runSpacing: 20,
      children: [
        TextField(
          onChanged: (value) {
            todoModel.toDoText = value;
          },
          decoration: const InputDecoration(
              hintText: "TodoText", border: OutlineInputBorder()),
        ),
        TextField(
          decoration: const InputDecoration(
              hintText: "isDone", border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
