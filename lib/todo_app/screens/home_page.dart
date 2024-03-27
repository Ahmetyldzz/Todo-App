import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class TodoApp extends StatefulWidget {
  TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final todosList = ToDo.toDoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ProjectColors().grey,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.menu,
                color: ProjectColors().black,
                size: 30,
              ),
              Text(
                "ToDo app",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: ProjectColors().black),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/images/avatar.jpg')),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Container(
                //color: Colors.amber,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Text(
                        "All ToDos",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(),
                      ),
                    ),
                    for (ToDo todoo in _foundToDo)
                      ToDoItem(
                        todo: todoo,
                        onDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                  ],
                ),
              ),
              Container(
                  color: Colors.amber, child: Expanded(child: SearchBox())),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                              hintText: "Add a new todo item",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _addToDoItem(_todoController.text);
                      },
                      child: Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 15, bottom: 20),
                          decoration: BoxDecoration(
                              color: ProjectColors().commonTheme,
                              borderRadius: BorderRadius.circular(5)),
                          width: 60,
                          height: 60,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          toDoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> result = [];
    if (enteredKeyword.isEmpty) {
      result = todosList;
    } else {
      result = todosList
          .where((item) => item.toDoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        _foundToDo = result;
      });
    }
  }

  Widget SearchBox() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search",
              border: InputBorder.none),
        ),
      ),
    );
  }
}

/* class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          onChanged: (value) => ,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search",
              border: InputBorder.none),
        ),
      ),
    );
  }
} */
