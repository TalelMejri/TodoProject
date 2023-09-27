import 'package:flutter/material.dart';
import 'package:mobile/Screens/Auth/Login.dart';
import 'package:mobile/Screens/Auth/Register.dart';
import 'package:mobile/Screens/Loading.dart';
import 'package:mobile/Screens/Todos.dart';
import 'package:mobile/Services/AuthService.dart';

void main(){
    runApp(const HomePage());
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState()=>_HomePage();
}

class _HomePage extends State<HomePage>{

  Widget layout=Loading();

  AuthService authService=AuthService();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
       authService.getUserFromStorage().then((value) =>
          setState((){
              layout=authService.isAuth ? Todos(user: authService.user,) :  LoginUser(message: '',);
          })
       );
    });
    super.initState();
  }
  
  @override 
  Widget build(BuildContext context){
    return  MaterialApp(
       debugShowCheckedModeBanner: false,
        title: 'Todos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
        ),
      home: layout
    );
  }
}