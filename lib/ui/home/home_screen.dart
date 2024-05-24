
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_project/model/todo_list_model.dart';
import 'package:test_project/utils/app_dialogs.dart';

import 'home_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _todoForm = GlobalKey<FormBuilderState>();
  late final  HomeBloc bloc;
  String id='';
  @override
  void initState(){
    super.initState();
    bloc=BlocProvider.of<HomeBloc>(context);
    bloc.add(GetTodoListEvent());
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: Padding(padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<HomeBloc,HomeState>(
                buildWhen: (previousState,currentState)=>
                previousState.isLoadingUpdateTodo!=currentState.isLoadingUpdateTodo||
                previousState.isSuccessUpdateTodo!=currentState.isSuccessUpdateTodo||
                previousState.isErrorUpdateTodo!=currentState.isErrorUpdateTodo,
                listenWhen: (previousState,currentState)=>
                previousState.isLoadingUpdateTodo!=currentState.isLoadingUpdateTodo||
                previousState.isSuccessUpdateTodo!=currentState.isSuccessUpdateTodo||
                previousState.isErrorUpdateTodo!=currentState.isErrorUpdateTodo,
                builder: (context,state){
                if(state.isLoadingUpdateTodo==true){
                  return const Center(child: CircularProgressIndicator(),);
                }else{
                  return const SizedBox.shrink();
                }
              }, listener: (BuildContext context, HomeState state) {
                if(state.isSuccessUpdateTodo!=null){
                  AppsDialogs.statusDialog(context, 'success_dialog', 'Successfully Update');
                }else if(state.isErrorUpdateTodo!=null){
                  AppsDialogs.statusDialog(context, 'error_dialog', state.isErrorUpdateTodo??'Error!!');
                }
              },)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<HomeBloc,HomeState>(
                buildWhen: (previousState,currentState)=>
                previousState.isLoadingDeleteTodo!=currentState.isLoadingDeleteTodo||
                    previousState.isSuccessDeleteTodo!=currentState.isSuccessDeleteTodo||
                    previousState.isErrorDeleteTodo!=currentState.isErrorDeleteTodo,
                listenWhen: (previousState,currentState)=>
                previousState.isLoadingDeleteTodo!=currentState.isLoadingDeleteTodo||
                    previousState.isSuccessDeleteTodo!=currentState.isSuccessDeleteTodo||
                    previousState.isErrorDeleteTodo!=currentState.isErrorDeleteTodo,
                builder: (context,state){
                  if(state.isLoadingDeleteTodo==true){
                    return const Center(child: CircularProgressIndicator(),);
                  }else{
                    return const SizedBox.shrink();
                  }
                }, listener: (BuildContext context, HomeState state) {
                if(state.isSuccessDeleteTodo!=null){
                  AppsDialogs.statusDialog(context, 'success_dialog', 'Successfully Delete');
                }else if(state.isErrorDeleteTodo!=null){
                  AppsDialogs.statusDialog(context, 'error_dialog', state.isErrorDeleteTodo??'Error!!');
                }
              },)
            ],
          ),
          BlocBuilder<HomeBloc,HomeState>(
              buildWhen: (previousState,currentState)=>previousState.isLoading!=currentState.isLoading||
                  previousState.isSuccess!=currentState.isSuccess||
                  previousState.isSuccessAddTodo!=currentState.isSuccessAddTodo||
                  previousState.isSuccessUpdateTodo!=currentState.isSuccessUpdateTodo||
                  previousState.isSuccessDeleteTodo!=currentState.isSuccessDeleteTodo||
                  previousState.isError!=currentState.isError,
              builder: (context,state){
            if(state.isLoading==true){
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 15,),
                    Text('Loading...')
                  ],
                ),
              );
            }else if(state.isSuccess!=null){
              List<Todos>?todoList=state.isSuccess?.todos;
              if(state.isSuccessAddTodo!=null){
                todoList?.insert(0, state.isSuccessAddTodo!);
              }
              if(state.isSuccessUpdateTodo!=null){
                int? indexValue =todoList?.indexWhere((element) => element.id==state.isSuccessUpdateTodo?.id);
               if(indexValue!=-1){
                 Future.delayed(const Duration(seconds: 1),(){
                   todoList?[indexValue!]=state.isSuccessUpdateTodo!;
                 });
               }
              }
              if(state.isSuccessDeleteTodo!=null){
                int? indexValue =todoList?.indexWhere((element) =>
                element.id==state.isSuccessDeleteTodo?.id);
               if(indexValue!=-1){
                 Future.delayed(const Duration(seconds: 1),(){
                   todoList?.removeAt(indexValue!);
                 });
               }
              }
              return Expanded(
                child: ListView.builder(
                    itemCount: todoList?.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(todoList?[index].todo??"",maxLines: 1,overflow: TextOverflow.ellipsis,),
                        trailing: Wrap(
                          children: [
                            IconButton(onPressed: (){
                              dialogBox(context,'Update Todo',);
                              Future.delayed(const Duration(milliseconds: 300),(){
                                id=todoList?[index].id.toString()??"";
                                _todoForm.currentState?.fields['description']?.didChange(todoList?[index].todo);
                              });
                            }, icon: const Icon(Icons.edit,color: Colors.green,)),
                            IconButton(onPressed: (){
                              bloc.add(DeleteTodoEvent(todoList?[index].id.toString()??''));
                            }, icon: const Icon(Icons.delete,color: Colors.red,))
                          ],
                        ),
                      );
                    }),
              );
            }else if(state.isError!=''){
              return Center(
                child: Text(state.isError??''),
              );
            }
            else{
              return const SizedBox.shrink();
            }
          }),
        ],
      ),),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child:
                ElevatedButton(onPressed: (){
                  dialogBox(context,'Add Todo',);
                }, child:  BlocBuilder<HomeBloc,HomeState>(
                    buildWhen: (previousState,currentState)=>previousState.isLoadingAddTodo!=currentState.isLoadingAddTodo||
                        previousState.isSuccessAddTodo!=currentState.isSuccessAddTodo||
                        previousState.isErrorAddTodo!=currentState.isErrorAddTodo,
                    builder: (context,state){
                      return state.isLoadingAddTodo==true?const CircularProgressIndicator(
                        color: Colors.white,
                      ):const Text('Add New');
                    }))
            )

          ],
        ),
      ),
    ));
  }

   Future dialogBox(BuildContext context,
      String dialogType,) {
    return
      showDialog(
        context:  context,
        builder: (context) {
          return Container(
            width: double.infinity, // Full width
            alignment: Alignment.center, // Align at the bottom
           // padding: EdgeInsets.all(10),
            child: AlertDialog(
              //alignment: Alignment.bottomCenter,
              insetPadding: const EdgeInsets.all(10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              contentPadding: const EdgeInsets.only(top: 15.0,),
              backgroundColor: Colors.white,
              elevation: 5.0,
              title: Center(
                child: Text(dialogType??'Dialog',style: Theme.of(context).textTheme.headlineSmall,),
              ),
              titleTextStyle: Theme.of(context).textTheme.headlineMedium,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
                  key: _todoForm,
                  child:  FormBuilderTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    name: 'description',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Description'),
                  ),

                ),
              ),
              actions: <Widget>[
                const SizedBox(
                  height: 12,
                ),
                Center(
                    child:
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_todoForm.currentState!.validate()){
                            if(dialogType=='Add Todo'){
                              bloc.add(AddTodoEvent(_todoForm.currentState?.fields['description']?.value));
                            }else{
                              bloc.add(UpdateTodoEvent(_todoForm.currentState?.fields['description']?.value,id));
                            }
                         Navigator.pop(context);
                          }
                        },
                        child:  Text(
                          dialogType,
                        ),
                      ),
                    )
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          );
        },
      );


  }
}
