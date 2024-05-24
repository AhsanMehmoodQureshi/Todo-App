class TodoList {
  TodoList({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });
  late final List<Todos> todos;
  late final int total;
  late final int skip;
  late final int limit;

  TodoList.fromJson(Map<String, dynamic> json){
    todos = List.from(json['todos']).map((e)=>Todos.fromJson(e)).toList();
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['todos'] = todos.map((e)=>e.toJson()).toList();
    _data['total'] = total;
    _data['skip'] = skip;
    _data['limit'] = limit;
    return _data;
  }
}

class Todos {
  Todos({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });
  late final int id;
  late final String todo;
  late final bool completed;
  late final int userId;

  Todos.fromJson(Map<String, dynamic> json){
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['todo'] = todo;
    _data['completed'] = completed;
    _data['userId'] = userId;
    return _data;
  }
}