
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile/Model/User.dart';

class AuthService {

  bool isAuth=false;
  String url="http://192.168.1.19:8000/Auth";  // device externe
   //String url="http://10.0.2.2:8000/Auth"; // emulator
  String errorRegister="";
  String errorLogin="";
  String token="";
  

  final Storage=FlutterSecureStorage();

  late User ? user=null;

   AuthService() {
      getUserFromStorage();
  }

   Future<void> getUserFromStorage() async {
    var token = await Storage.read(key: "token");
    var user_data = await Storage.read(key: "user");
    if (token != null && user_data!=null ) {
        user= User.fromJson(jsonDecode(user_data));
        this.token=token;
        isAuth = true;
    }else{
        isAuth=false;
    }
  }

  Future<void> logout()async{
     await Storage.delete(key: "token");
  }

 Future<bool> Register(String nom,String email,String password,String image)async{
      final request={"nom":nom,"email":email,"password":password,"imageProfile":image};
      try{
          final response=await http.post(Uri.parse("$url/SignUp"),
                body: jsonEncode(request),
                headers: {"Content-Type":"application/json;charset=utf-8"}
          );
          if(response.statusCode==200){
            return true;
          }else{
            errorRegister = response.body;
            return false;
          }
      }catch(e){
        print(e);
        errorRegister=e.toString();
        return false;
      }
 }

 Future<bool> LoginUser(String email,String password)async{
     final request={"email":email,"password":password};
     try{
      final response=await http.post(Uri.parse("$url/Login",),
            body: jsonEncode(request),
            headers: {"Content-Type":"application/json"}
          );
   
    if(response.statusCode==200){
      isAuth=true;
          final Map<String, dynamic> responseData = json.decode(response.body);
          final userData = responseData['user'];
         if (userData != null) {
            user = User.fromJson(userData);
             final List<String> cookies = response.headers['set-cookie']?.split(';') ?? [];
             String token = '';

            if (cookies != null) {
                for (String cookie in cookies) {
                   if (cookie.startsWith('Token=')) {
                      token = cookie.substring(6); 
                      break;
                  }
                }
            }
            isAuth = true;
            this.token = token;
            Storage.write(key: "token", value: token); 
            Storage.write(key: "user", value: jsonEncode(user!.toJson()));
            return true;
          } else {
            errorLogin = "User data not found in response !!!! ";
            return false;
         }
    }else{
      errorLogin=response.body;
      return false;
    }
     }catch(e){
       print(e);
       return false;
     }
 }


}