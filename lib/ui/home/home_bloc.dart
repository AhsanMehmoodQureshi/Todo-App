import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/model/todo_list_model.dart';
import 'package:test_project/utils/api_url.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(const HomeState()) {
    on<GetTodoListEvent>(_getTodoList);
    on<AddTodoEvent>(_addTodoData);
    on<UpdateTodoEvent>(_updateTodoData);
    on<DeleteTodoEvent>(_deleteTodo);

  }
  void _getTodoList(GetTodoListEvent event,Emitter<HomeState> emit)async{
      try {
        emit(state.copyWith(isLoading: true,isSuccess: null,isError: ''));
        final response = await http.get(Uri.parse(ApiUrl.baseUrl));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          emit(state.copyWith(isLoading: false,isSuccess: TodoList.fromJson(data),isError: ''));
        } else {
          emit(state.copyWith(isLoading: false,isSuccess: null,isError: 'Failed to get todo list: ${response.statusCode}'));
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false,isSuccess: null,isError: 'An error occurred: $e'));
      }
  }
  void _addTodoData(AddTodoEvent event,Emitter<HomeState>emit)async{
    final url = Uri.parse('${ApiUrl.baseUrl}/add');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'todo': event.addTodo,
      'completed': false,
      'userId': 5,
    });
    try {
      emit(state.copyWith(isLoadingAddTodo: true,isSuccessAddTodo: null,isErrorAddTodo: null));
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        emit(state.copyWith(isLoadingAddTodo: false,isSuccessAddTodo: Todos.fromJson(jsonResponse),
            isErrorAddTodo: null));
      } else {
        emit(state.copyWith(isLoadingAddTodo: false,isSuccessAddTodo: null,
            isErrorAddTodo: 'Failed to create todo. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(state.copyWith(isLoadingAddTodo: false,isSuccessAddTodo: null,
          isErrorAddTodo: 'An error occurred: $e'));
    }
  }
  void _updateTodoData(UpdateTodoEvent event,Emitter<HomeState>emit)async{
    final url = Uri.parse('${ApiUrl.baseUrl}/${event.index}');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'todo':event.updateTodo,
      'completed': false,
      'userId': 5,
    });

    try {
      emit(state.copyWith(isLoadingUpdateTodo: true,isSuccessUpdateTodo: null,isErrorUpdateTodo: null));
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        emit(state.copyWith(isLoadingUpdateTodo: false,isSuccessUpdateTodo: Todos.fromJson(jsonResponse),
            isErrorUpdateTodo: null));
      } else {
        emit(state.copyWith(isLoadingUpdateTodo: false,isSuccessUpdateTodo: null,
            isErrorUpdateTodo: 'Failed to create update. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(state.copyWith(isLoadingUpdateTodo: false,isSuccessUpdateTodo: null,
          isErrorUpdateTodo: 'An error occurred: $e'));
    }
  }
  void _deleteTodo(DeleteTodoEvent event,Emitter<HomeState>emit)async{
    final url = Uri.parse('${ApiUrl.baseUrl}/${event.index}');
    try {
      emit(state.copyWith(isLoadingDeleteTodo: true,isSuccessDeleteTodo: null,isErrorDeleteTodo: null));
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        emit(state.copyWith(isLoadingDeleteTodo: false,isSuccessDeleteTodo: Todos.fromJson(jsonResponse),isErrorDeleteTodo: null));
      } else {
        emit(state.copyWith(isLoadingDeleteTodo: false,isSuccessDeleteTodo: null,
            isErrorDeleteTodo: 'Request failed with status: ${response.statusCode}.'));

      }
    } catch (e) {
      emit(state.copyWith(isLoadingDeleteTodo: false,isSuccessDeleteTodo: null,
          isErrorDeleteTodo: 'An error occurred: $e .'));
    }
  }
  void reset() {
    emit(const HomeState());
  }
}
