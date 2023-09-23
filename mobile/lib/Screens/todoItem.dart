import 'package:flutter/material.dart';
import 'package:mobile/Model/Todo.dart';

class tododiTem extends StatelessWidget {
  final Todo todo;
  final deleteTodo;
  final updatedTodo;
  final check;

  const tododiTem({
    Key? key,
    required this.todo,
    required this.deleteTodo,
    required this.updatedTodo,
    required this.check
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon:todo.isdone ?const  Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
                onPressed: (){check();},
                color: Colors.blue,
              ),
              Expanded(
                child: Text(
                  todo.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration:
                        todo.isdone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              Row(
                children: [
                Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.only(right: 18),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.yellow),
                  child:  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                    iconSize: 20,
                    onPressed: () { 
                      updatedTodo();
                    },
                  ),
                ),
                  Container(
                     height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5),
                       color: Colors.red
                    ),
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 20,
                        icon:const Icon(Icons.delete),
                        onPressed: (){deleteTodo();},
                      ),
                   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
