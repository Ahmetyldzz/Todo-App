import 'package:sqflite/sqflite.dart';
import 'package:todo_app/todo_app/model/todo.dart';

class TodoDatabaseProvider {
  String _todoDatabaseName = "todoDatabase";
  String _todoTableName = "todo";
  int _version = 1;
  Database? database;
  String columnId = "id";
  String columnToDoText = "toDoText";
  String columnIsDone = "isDone";
  Future<void> open() async {
    database = await openDatabase(
      _todoDatabaseName,
      version: _version,
      onCreate: (db, version) {
        createTable(db);
        print("object");
      },
    );
  }

  Future<void> createTable(Database db) async {
    await db.execute(
        "CREATE TABLE $_todoTableName ( $columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnToDoText VARCHAR(30), $columnIsDone INTEGER)");
  }

  Future<int> deleteTodo(int id) async {
    var db = await this.database;
    int result = await db
            ?.rawDelete("DELETE FROM $_todoTableName WHERE $columnId = $id") ??
        0;
    return result;
  }

  Future<List<TodoModel>?> getList() async {
    if (database != null) open();
    List<Map<String, Object?>>? todoMaps =
        await database?.query(_todoTableName);
    return todoMaps?.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<TodoModel?> getItem(int id) async {
    if (database != null) open();
    final todoMaps = (await database?.query(
      _todoTableName,
      where: '$columnId = ?',
      columns: [columnId],
      whereArgs: [id],
    ));

    if (todoMaps!.isNotEmpty) {
      return TodoModel.fromJson(todoMaps.first);
    } else {
      return null;
    }
  }

  Future<bool> delete(int id) async {
    if (database != null) open();
    final todoMaps = (await database?.delete(
      _todoTableName,
      where: '$columnId = ?',
      whereArgs: [id],
    ));

    return todoMaps != null;
  }

  Future<bool> update(int id, TodoModel todoModel) async {
    if (database != null) open();
    final todoMaps = (await database?.update(
      _todoTableName,
      todoModel.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    ));

    return todoMaps != null;
  }

   

  Future<bool> insert(TodoModel todoModel) async {
    if (database != null) open();
    final todoMaps = (await database?.insert(
      _todoTableName,
      todoModel.toJson(),
    ));

    return todoMaps != null;
  }

  Future<void> close() async {
    await database?.close();
  }
}
