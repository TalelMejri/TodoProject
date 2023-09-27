import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/Screens/Auth/Login.dart';
import 'package:mobile/Services/AuthService.dart';

class RegisterUser extends StatefulWidget{
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState()=>_RegisterUser();
}

class _RegisterUser extends State<RegisterUser>{

  String nom="";
  String email="";
  String password="";
  File ? imagePicker;
  String base64Image="";
  String imageError="";
  bool Hidden=true;
  final formkey=GlobalKey<FormState>();
  AuthService auth=AuthService();

  Future<void> onChangeImage(ImageSource source)async{
    try{
      XFile ? pickeImage=await ImagePicker().pickImage(source: source);
      if(pickeImage!=null){
              final bytes = await (pickeImage).readAsBytes();
        setState(() {
              final bytes = File(pickeImage!.path).readAsBytesSync();
              imagePicker=File(pickeImage.path);
              base64Image =  "data:image/png;base64,"+base64Encode(bytes);
        });
      }else{
        imageError=="Image Required";
      }
    }catch(e){
      print(e);
    }
  }

  Future<void> register()async{
    print(nom);
    if(formkey.currentState!.validate()){
         if(imagePicker==null){
        setState(() {
          imageError="Image Required";
        });
        return;
      }
      try{
      final registerOk=await auth.Register(nom, email, password, base64Image);
        if(registerOk==true){
           Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginUser(message: "User Created Successfully",)));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(auth.errorRegister),backgroundColor: Colors.red,)
            );
        }
      }catch(e){
        print(e);
      }
    }else{
      if(imagePicker==null){
        setState(() {
          imageError="Image Required";
        });
      }
    }
  }

  
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(25),child: 
        Center(
          child:  Column(children: [
            const SizedBox(height: 100,),
            const Text("Create User",style: TextStyle(fontSize: 24),),
            const SizedBox(height: 30),
            Form(key:formkey, child: Column(
               children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val){
                    if(val==null || val.isEmpty){
                      return "Nom Required";
                    }
                    return null;
                  },
                    onChanged: (val){
                    setState(() {
                      nom=val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius:BorderRadius.circular(14) ),
                    hintText: "Nom",
                    label: const Text("Enter Nom"),
                  ),
                ),
                  const SizedBox(height: 20),
                  TextFormField(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: (){onChangeImage(ImageSource.gallery);}, child: const Text("Chose Your Photo")),
                    imagePicker==null ? const Text("No Image Selected") : Image.file(imagePicker!,width: 50),
                  ],
                ),
                Text(imageError.isNotEmpty ? imageError : '',style: const TextStyle(color: Colors.red),),
                const SizedBox(height: 50),
                ElevatedButton(onPressed: (){register();},style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),child: const Text("Submit",style: TextStyle(color: Colors.white),))
               ],
            )),
                ElevatedButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginUser(message: '',)));
            }, style: ElevatedButton.styleFrom(elevation: 0),child: const Text("Already Have An Account",style: TextStyle(color: Colors.blue),),)
        ]),
        ),
        )
      ),
    );
  }
}