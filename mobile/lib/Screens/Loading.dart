import 'package:flutter/material.dart';
import 'package:mobile/Services/AuthService.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _Loading();
}

class _Loading extends State<Loading> {
  AuthService authService=AuthService();
  String nom="";
  @override
  void initState() {
       authService.getUserFromStorage().then((value) =>
       setState((){
          nom=authService.isAuth ? authService.user!.Nom : '';
       })
       );
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text("Hello ${nom}",style: const TextStyle(color: Colors.black,fontSize: 25),),)
    );
  }
}