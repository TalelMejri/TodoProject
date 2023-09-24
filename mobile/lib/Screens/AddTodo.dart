import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/Services/Todo.dart';

class AddTodo extends StatefulWidget{
   const AddTodo({super.key});

   @override
   State<AddTodo> createState()=>_AddTodo();
}

class _AddTodo extends State<AddTodo>{

  final _formKey = GlobalKey<FormState>();

  late TodoService todoService=TodoService();

  String Name="";
  String Description="";
  var date=null;
  bool loading=false;
  String errorDate="";

  Future<void> ShowDateTime()async{
    DateTime ? datepicker=await showDatePicker(
      context: context,
       initialDate: DateTime.now(), 
       firstDate: DateTime(1900), 
       lastDate: DateTime(2030)
      ); 
    if(datepicker!=null){
      setState(() {
        date=datepicker.toLocal().toString();
        errorDate="";
      });
    }
  }

  void AddTodoFnction()async{
    if (_formKey.currentState!.validate()) {
           final request={"name":Name,"description":Description,"due_date":date};
           await todoService.AddTodo(request);
           Navigator.of(context).pop("test");
    }else{
      if(date==null){
        setState(() {
             errorDate="Date Required";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo",style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,),
      body: 
         SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                ],
                 ),
                child: Image.asset(
                  "images/hero-img.png", 
               ),
              ),
              Padding(
                padding:const EdgeInsets.all(50),
                child:Form(
                  key: _formKey,
                  child: Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (val){
                        setState(() {
                          Name=val;
                        });
                      },
                      validator: (val){
                        if(val==null || val.isEmpty){
                          return "Name Required";
                        }
                        return null;
                      },
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    hintText: "Enter Name",
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: "Name",
                  ),
                 ),
               ),
               const SizedBox(height: 20),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      validator: (val){
                        if(val==null || val.isEmpty){
                          return "Description Required";
                        }
                        return null;
                      },
                         autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (val){
                        setState(() {
                          Description=val;
                        });
                      },
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    hintText: "Enter Description",
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: "Description",
                  ),
                 ),
               ),
               const SizedBox(height: 20,),
               Container(
                padding:const EdgeInsets.all(15),
                child:
                  ElevatedButton.icon(onPressed: (){ ShowDateTime();}, icon:const Icon(Icons.date_range_sharp,color: Colors.white),label: const Text("Date",style: TextStyle(color: Colors.white)),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),)
               ),
               Container(
                child:    errorDate.isNotEmpty ? Text(errorDate,style: const TextStyle(color: Colors.red)) : null,
               ),
               const SizedBox(height: 40),
               ElevatedButton(onPressed: (){AddTodoFnction();},style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5),
               ),
               backgroundColor: const Color.fromARGB(255, 6, 43, 74)
               ),child: loading ? const CircularProgressIndicator() : const Text("Add",style: TextStyle(color: Colors.white)))
              ],
            ),
            ),
          ),
          ],
        ),
        )
    );
  }
}