import 'dart:convert';
import 'package:mobile/Model/Todo.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/Services/AuthService.dart';



class TodoService  {

     List<Todo> todos=[];
      late AuthService authService=AuthService();
    
     String url="http://10.0.2.2:8000/Todo";

  Future<List<Todo>> getTodos(String search ) async {
      await authService.getUserFromStorage();
  try {
     final Uri uri = Uri.parse('$url/GetTodos?${search.isNotEmpty ? 'search=$search' : ''}');
     final response = await http.get(uri,headers: {'cookie': 'Token=${authService.token}'} );
    if (response.statusCode == 200) {
        final  jsonData = jsonDecode(response.body);
        /* for (var item in jsonData) {
          todos.add(Todo.fromJson(item));
        }*/
        todos = jsonData.map<Todo>((json) => Todo.fromJson(json)).toList();
        return todos;
    }else{
      return [];
    }
  } catch (e) {
    print('Error fetching todos: $e');
    return [];
  }
}

  Future<void> UpdatedSatatus(int id)async {
     await authService.getUserFromStorage();
  try{
    final response =  await http.put(Uri.parse('$url/updateStatus?id='+id.toString()),headers: {'cookie': 'Token=${authService.token}'});
    if(response.statusCode==200){
      print("statusChange");
    }else{
      print(response.body);
    }
  }catch(e){
    print(e);
  }
}

Future<void> deleteTodo(int id) async{
   await authService.getUserFromStorage();
  try{
    final response=await http.delete(Uri.parse('$url/DeleteTodo?id='+id.toString()),headers: {'cookie': 'Token=${authService.token}'});
    if(response.statusCode==200){
      print("statchange");
    }else{
      print(response.body);
    }
  }catch(e){
    print(e);
  }
}

Future<void> AddTodo(request)async{
   await authService.getUserFromStorage();
  try{
    final response=await http.post(Uri.parse('$url/AddTodo',),
      body: jsonEncode(request),
      headers: {
        'Content-Type': 'application/json',
        'withCredentials': 'true',
        'cookie': 'Token=${authService.token}'
        }
   );
   if(response.statusCode==200){
      print("done");
   }else{
    print(response.body);
   }
  }catch(e){
    print(e);
  }
}

Future<void> UpdateTodo(request,id)async{
    await authService.getUserFromStorage();
    try{
      final response=await http.put(Uri.parse('$url/UpdateTodo?id='+id.toString()),
      body: jsonEncode(request),
      headers:{
        'Content-Type':'application/json',
        'cookie': 'Token=${authService.token}'
        }
    );
      if(response.statusCode==200){
      print("done");
   }else{
    print(response.body);
   }
    }catch(e){
      print(e);
    }
}

}