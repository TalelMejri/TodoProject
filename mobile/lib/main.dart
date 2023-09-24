import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/Model/Todo.dart';
import 'package:mobile/Screens/AddTodo.dart';
import 'package:mobile/Screens/todoItem.dart';
import 'Services/Todo.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

class _MyHomePageState extends State<MyHomePage>   {


    late TodoService todoService=TodoService();
    List<Todo> todos=[];
    String search="";
  @override
  void initState() {
     super.initState();
     

     fetchTodos(); 
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
                MaterialPageRoute(builder: (BuildContext context) => AddTodo()), 
          );
          if(res=="test"){
            await fetchTodos();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("TodoAdded"))
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
      appBar: AppBar(title:const Center(child: Text("Todos App"),) ,backgroundColor:const Color(0xFFEEEFF5),elevation: 5,),
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
            todos.isNotEmpty ?    ListView.builder( shrinkWrap: true,itemCount: todos.length,itemBuilder: (context,index){
              final todo=todos[index];
              return tododiTem(todo: todo,deleteTodo: deleteTodo,updatedTodo: updatedTodo,check:check,InfoTodo:InfoTodo);
          }) :  const Text("No Todos",style: TextStyle(fontSize: 20),)
        )
      ],)
      ),
    );
  }
}
