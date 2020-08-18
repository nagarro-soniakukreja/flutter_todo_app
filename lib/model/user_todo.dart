

class UserTodo{

  final userId;
  final id;
  final title;
  final completed;

  UserTodo(this.userId, this.id, this.title, this.completed);

  factory UserTodo.fromJson(Map<String, dynamic> json) {
    return UserTodo(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['completed'] as bool,
    );
  }
}