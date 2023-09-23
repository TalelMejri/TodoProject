import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/Model/Todo.dart';
import 'package:http/http.dart' as http;
class TodoService  {
    List<Todo> todos=[];

  String url="http://10.0.2.2:8000/Todo";
 Future<List<Todo>> getTodos() async {
  try {
    final response = await http.get(Uri.parse('$url/GetTodos'));
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
}