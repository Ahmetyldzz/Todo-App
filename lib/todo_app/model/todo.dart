// ignore_for_file: public_member_api_docs, sort_constructors_first
class ToDo {
  String? id;
  String? toDoText;
  bool isDone;
  ToDo({
    required this.id,
    required this.toDoText,
    this.isDone = false,
  });
  static List<ToDo> toDoList() {
    return [
      ToDo(id: "01", toDoText: "Morning Exercises", isDone: true),
      ToDo(id: "02", toDoText: "Evening Exercises"),
      ToDo(id: "03", toDoText: "Afternoon Exercises"),
      ToDo(id: "04", toDoText: "Weekend Exercises"),
      ToDo(id: "05", toDoText: "Saturday Exercises"),
    ];
  }
}
