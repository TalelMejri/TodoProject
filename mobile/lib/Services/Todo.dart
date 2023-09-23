import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/Model/Todo.dart';
import 'package:http/http.dart' as http;
class TodoService  {
  late List<Todo> ? todos=null;

  String url="http://10.0.2.2:8000/Todo";
 Future<void> getTodos() async {
  try {
    final response = await http.get(Uri.parse('$url/GetTodos'));
    if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        todos = jsonData.map<Todo>((json) => Todo.fromJson(json)).toList();
        print(todos);
    }
  } catch (e) {
    print('Error fetching todos: $e');
  }
}
}