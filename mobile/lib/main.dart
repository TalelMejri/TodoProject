import 'package:flutter/material.dart';
import 'package:mobile/Model/Todo.dart';
import 'Services/Todo.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TodoService todoService=TodoService();
  late List<Todo> ? todos=null;
 @override
  void initState() {
    todoService.getTodos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
