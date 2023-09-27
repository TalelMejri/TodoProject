import 'package:flutter/material.dart';
import 'package:mobile/Screens/Auth/Register.dart';
import 'package:mobile/Services/AuthService.dart';
import 'package:mobile/main.dart';

class LoginUser extends StatefulWidget{
   LoginUser({super.key,required this.message});

  String  message;

  @override
  State<LoginUser> createState()=>_LoginUser();
}

class _LoginUser extends State<LoginUser>{
  bool Hidden=true;
  @override
  void initState() {
     super.initState();
     Future.delayed(const Duration(seconds: 3),(){
         if(widget.message.isNotEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${widget.message}"),backgroundColor: Colors.blue,)
               );
        }
        setState(() {
          widget.message='';
        });
    });
  }

AuthService authService=AuthService();
    final formkey=GlobalKey<FormState>();
    String email="";
    String password="";
    Future<void> Login()async{
      if(formkey.currentState!.validate()){
   final res=await authService.LoginUser(email, password);
      if(res==true){
           Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
      }else{
         ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(authService.errorLogin),backgroundColor: Colors.red,)
            );
      }
      }
    }
  @override
  Widget build(BuildContext context){
    return    Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(25),child: 
        Center(
          child:  Column(children: [
            const SizedBox(height: 100,),
            const Text("Login ",style: TextStyle(fontSize: 24),),
            const SizedBox(height: 30),
            Form(key:formkey, child: Column(
               children: [
                  const SizedBox(height: 20),
                  TextFormField(
                  keyboardType: TextInputType.emailAddress,  
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val){
                    if(val==null || val.isEmpty){
                      return "Email Required";
                    }
                    return null;
                  },
                  onChanged: (val){
                    setState(() {
                      email=val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius:BorderRadius.circular(14) ),
                    hintText: "lbeez@gmail.com",
                    label: const Text("Enter Email"),
                  ),
                ),
                  const SizedBox(height: 20),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val){
                    if(val==null || val.isEmpty){
                      return "Password Required";
                    }
                    return null;
                  },
                    onChanged: (val){
                    setState(() {
                      password=val;
                    });
                  },
                  obscureText: Hidden,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius:BorderRadius.circular(14)),
                    hintText: "*******",
                    label: const Text("Enter Password"),
                      suffixIcon:IconButton(icon: Icon(!Hidden ? Icons.visibility : Icons.visibility_off),onPressed: (){
                       setState(() {
                         Hidden=!Hidden;
                       });
                    },
                    )
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 50),
                ElevatedButton(onPressed: (){Login();},style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),child: const Text("Submit",style: TextStyle(color: Colors.white),))
               ],
            ),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>const RegisterUser()));
            }, style: ElevatedButton.styleFrom(elevation: 0),child: const Text("Create an Account",style: TextStyle(color: Colors.blue),),)
        ]),
        ),
        )
      ),
    );
  }
}