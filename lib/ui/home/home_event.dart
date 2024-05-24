import 'package:equatable/equatable.dart';


abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTodoListEvent extends HomeEvent {}
class AddTodoEvent extends HomeEvent {
  final String addTodo;
  AddTodoEvent(this.addTodo);
}
class UpdateTodoEvent extends HomeEvent {
  final String updateTodo;
  final String index;
  UpdateTodoEvent(this.updateTodo,this.index);
}
class DeleteTodoEvent extends HomeEvent {
  final String index;
  DeleteTodoEvent(this.index);
}