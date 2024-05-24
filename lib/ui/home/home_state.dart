
import 'package:equatable/equatable.dart';
import 'package:test_project/model/todo_list_model.dart';

class HomeState extends Equatable {
  final bool? isLoading;
  final TodoList? isSuccess;
  final String? isError;
  final bool? isLoadingAddTodo;
  final Todos? isSuccessAddTodo;
  final String? isErrorAddTodo;
  final bool? isLoadingUpdateTodo;
  final Todos? isSuccessUpdateTodo;
  final String? isErrorUpdateTodo;
  final bool? isLoadingDeleteTodo;
  final Todos? isSuccessDeleteTodo;
  final String? isErrorDeleteTodo;
  const HomeState( {
    this.isLoading,
    this.isSuccess,
    this.isError,
    this.isLoadingAddTodo,
    this.isSuccessAddTodo,
    this.isErrorAddTodo,
    this.isLoadingUpdateTodo,
    this.isSuccessUpdateTodo,
    this.isErrorUpdateTodo,
    this.isLoadingDeleteTodo,
    this.isSuccessDeleteTodo,
    this.isErrorDeleteTodo
  });

  HomeState copyWith({
    bool? isPasswordVisible,
    bool? isLoading,
    TodoList? isSuccess,
    String? isError,
     bool? isLoadingAddTodo,
     Todos? isSuccessAddTodo,
     String? isErrorAddTodo,
    bool? isLoadingUpdateTodo,
    Todos? isSuccessUpdateTodo,
    String? isErrorUpdateTodo,
     bool? isLoadingDeleteTodo,
     Todos? isSuccessDeleteTodo,
     String? isErrorDeleteTodo,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      isLoadingAddTodo: isLoadingAddTodo ?? this.isLoadingAddTodo,
      isSuccessAddTodo: isSuccessAddTodo ?? this.isSuccessAddTodo,
      isErrorAddTodo: isErrorAddTodo ?? this.isErrorAddTodo,
      isLoadingUpdateTodo: isLoadingUpdateTodo ?? this.isLoadingUpdateTodo,
      isSuccessUpdateTodo: isSuccessUpdateTodo ?? this.isSuccessUpdateTodo,
      isErrorUpdateTodo: isErrorUpdateTodo ?? this.isErrorUpdateTodo,
      isLoadingDeleteTodo: isLoadingDeleteTodo ?? this.isLoadingDeleteTodo,
      isSuccessDeleteTodo: isSuccessDeleteTodo ?? this.isSuccessDeleteTodo,
      isErrorDeleteTodo: isErrorDeleteTodo ?? this.isErrorDeleteTodo,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isError,
    isLoadingAddTodo,
    isSuccessAddTodo,
    isErrorAddTodo,
     isLoadingUpdateTodo,
     isSuccessUpdateTodo,
     isErrorUpdateTodo,
    isLoadingDeleteTodo,
    isSuccessDeleteTodo,
    isErrorDeleteTodo,
  ];
}
