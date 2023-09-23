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
    List<Todo> todos=[];
 @override
  void initState() {
     super.initState();
    fetchTodos(); 
  }

   Future<void> fetchTodos() async {
    await todoService.getTodos();
    setState(() {
      todos = todoService.todos; 
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.name),
            subtitle: Text(todo.description),
            // Add more widgets to display todo details as needed
          );
        },
      ),
    );
  }
}
