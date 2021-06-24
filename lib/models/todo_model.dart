class Task {
  int id;
  String todos;

  Task({this.todos });
  Task.withId({this.id, this.todos});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['todos'] =todos ;

    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
        id: map['id'],
        todos: map['todos']);
  }
}
