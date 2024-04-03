import 'package:flutter/material.dart';
import 'package:todo_app/todo_app/model/todo_database_provider.dart';

import '../model/todo.dart';
import '../constants/colors.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    todoDatabaseProvider = TodoDatabaseProvider();
    todoDatabaseProvider!.open();
    
    //todoList = todoDatabaseProvider?.getList() as List<TodoModel>;
    _foundToDo = todoList;
  }

  List<TodoModel> todoList = [];
  TodoDatabaseProvider? todoDatabaseProvider;
  TodoModel todoModel = TodoModel();
  List<TodoModel> _foundToDo = [];

  Future getTodoList() async {
    todoList = (await todoDatabaseProvider?.getList())!;
    setState(() {
      _foundToDo = todoList;
    });
  }

  Future<void> saveModel() async {
    final result = await todoDatabaseProvider?.insert(todoModel);
  }

  Future<void> updateModel(int id, TodoModel todoModel) async {
    final result = await todoDatabaseProvider?.update(id, todoModel);
    print("çalıştı");
  }

  void updateModell(int id, TodoModel todoModel) {
    setState(() {
      todoDatabaseProvider?.update(id, todoModel);
    });
  }

  Future<void> deleteItem(int id) async {
    await todoDatabaseProvider?.delete(id);

    print("silindi");
  }

  void isDone(int id) {
    setState(() {
      if (todoList[id].isDone == 0) {
        todoList[id].isDone = 1;
      } else {
        todoList[id].isDone = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors().background,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "All Todos",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _foundToDo.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: IconButton(
                                onPressed: () {
                                  print(index);
                                  if (todoList[index].isDone == 0) {
                                    updateModell(
                                        index,
                                        TodoModel(
                                            id: index,
                                            toDoText:
                                                "todoList[index].toDoText",
                                            isDone: 1));
                                    print("object");
                                  } else {
                                    TodoModel updatedTodoModel = TodoModel(
                                        id: 0,
                                        toDoText: todoList[0].toDoText,
                                        isDone: 0);
                                    updateModell(index, updatedTodoModel);
                                  }
                                },
                                icon: todoList[index].isDone == 0
                                    ? Icon(Icons.check_box_outline_blank)
                                    : Icon(Icons.check_box)),
                            trailing: IconButton(
                                onPressed: () {
                                  deleteItem(todoList[index].id ?? index);
                                  deleteItem(_foundToDo[index].id ?? index);
                                  getTodoList();
                                },
                                iconSize: 15,
                                icon: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  width: 27,
                                  height: 27,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                )),
                            title: Text(
                              _foundToDo[index].toDoText.toString(),
                            ),
                            subtitle: Text(_foundToDo[index].isDone.toString()),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 75,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      todoModel.toDoText = value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (todoModel.toDoText!.isNotEmpty) {
                      saveModel();
                    }

                    // _foundToDo = todoList;
                    // _runFilter("ahmet");

                    getTodoList();
                    //_addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProjectColors().commonTheme,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                  child: Icon(
                    Icons.add,
                    color: ProjectColors().background,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<TodoModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.toDoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        //onEditingComplete: () {},
        onChanged: (value) {
          _runFilter(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ProjectColors().background,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpg'),
          ),
        ),
      ]),
    );
  }
}
