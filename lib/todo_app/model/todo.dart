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

class TodoModel {
  int? id;
  String? toDoText;
  int? isDone;

  TodoModel({this.id, this.toDoText, this.isDone = 0});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    toDoText = json['toDoText'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['toDoText'] = this.toDoText;
    data['isDone'] = this.isDone;
    return data;
  }
}

class TodoModel1 {
  int? id;
  String? toDoText;

  TodoModel1({this.id, this.toDoText});

  TodoModel1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    toDoText = json['toDoText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['toDoText'] = this.toDoText;
    return data;
  }
}
