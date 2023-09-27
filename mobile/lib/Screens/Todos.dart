
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/Model/Todo.dart';
import 'package:mobile/Model/User.dart';
import 'package:mobile/Screens/AddTodo.dart';
import 'package:mobile/Screens/todoItem.dart';
import 'package:mobile/Services/AuthService.dart';
import 'package:mobile/Services/Todo.dart';
import 'package:mobile/main.dart';

class Todos extends StatefulWidget {
  Todos({super.key,required this.user});
  User ? user;
  @override
  State<Todos> createState() => _Todos();
}

class _Todos extends State<Todos> {

   late TodoService todoService=TodoService();
    List<Todo> todos=[];
    String search="";
  late AuthService authService=AuthService();
      @override
  void initState() {
    print("Todos");
     print(widget.user);
     super.initState();
     fetchTodos(); 
  }

  
Logout()async{
   authService.logout();
   Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
}
Future<void> deleteTodo(int id)async{
  String ? res=await showDialog(context: context, builder:(context){
    return AlertDialog(
      title: const  Text("Confirm Delete"),
      content: const Text("Do You Wanna Delete Todo"),
      actions: [
        Row(
          children: [
            ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child:const Text("Cancel")),
            ElevatedButton(onPressed: (){Navigator.of(context).pop("delete");}, child:const Text("Delete")),
          ],
        )
      ],
    );
  });

  if(res=="delete"){
    try{
      todoService.deleteTodo(id);
      await fetchTodos();
    }catch(e){
      print(e);
    }
  }
  fetchTodos();
}


void check(int id)async{
  await todoService.UpdatedSatatus(id);
  fetchTodos();
}

void InfoTodo(Todo todo){
  print(todo);
}

void updatedTodo(){
  print("update");
}
   Future<void> fetchTodos() async {
    todos=[];
     await todoService.getTodos(search);
     setState(() {
       todos = todoService.todos; 
     });
   }

   Future<void> SceerenAded()async{
     String ? res= await Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => AddTodo(IsUpdated: false,)), 
          );
          if(res=="test"){
            await fetchTodos();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("TodoAdded"))
            );
          }
   }

   Future<void> ScreenUpdate(Todo todo)async{
     String ? res= await Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => AddTodo(IsUpdated: true,todo: todo,)), 
          );
          if(res=="test"){
            await fetchTodos();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Todo Updated"))
            );
          }
   }

  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFEEEFF5),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            SceerenAded();
           },
        backgroundColor: Colors.blue,child:const Icon(Icons.add,color: Colors.white,)),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Center(child: Text("Todos List"),) ,backgroundColor:const Color(0xFFEEEFF5),elevation: 5,
        ),
        drawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.memory(
                  width: 50,
                  base64Decode((widget.user!.ImageProfile).split(',').last),
                  ),
                DrawerHeader(child: Text(widget.user!.Nom)),
                 ElevatedButton.icon(onPressed: (){
                      Logout();
                  }, icon: const Icon(Icons.logout), label:const Text("Logout"))
              ],
            ),
        ),
      body:Container(
         padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
        child: 
       Column(children: [
         Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
           decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            onChanged:(val){
              setState(() {
                  search=val;
              });
              fetchTodos();
            } ,
           decoration:const InputDecoration(
           prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          border: InputBorder.none,
          hintText: 'Search',
        ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded( child: 
            todos.isNotEmpty ? ListView.builder( shrinkWrap: true,itemCount: todos.length,itemBuilder: (context,index){
              final todo=todos[index];
              return tododiTem(todo: todo,deleteTodo: deleteTodo,updatedTodo: updatedTodo,check:check,InfoTodo:InfoTodo,ScreenUpdate:ScreenUpdate);
          }) :  const Text("No Todos",style: TextStyle(fontSize: 20),)
        )
      ],)
      ),
    );
  }
}