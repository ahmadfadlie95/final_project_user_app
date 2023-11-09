import 'dart:convert';

import 'package:final_project_user_app/widgets/home.dart';
import 'package:final_project_user_app/widgets/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {

  var userEmail = TextEditingController();
  var userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextField(controller: userEmail, keyboardType: TextInputType.emailAddress,decoration: InputDecoration(hintText: "Email"),),
              SizedBox(height: 8),
              TextField(controller: userPassword, obscureText: true, decoration: InputDecoration(hintText: "Password"), ),
              SizedBox(height: 8),
              TextButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(100, 50)),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.zero))
                  ),
                  onPressed: (){
                    print(userEmail.text);
                    print(userPassword.text);
                    login(userEmail.text, userPassword.text).then((value)async{
                      print(value.body);
                      print(value.statusCode);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                       if(value.statusCode == 200){
                         //save token
                         SharedPreferences prefs = await SharedPreferences.getInstance();
                         prefs.setString("token", jsonDecode(value.body)["token"]);
                         //redirect to homepage
                         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                       }else{

                       }
                    });
                  }, child: Text("Login")),
              SizedBox(height: 8),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                  }, child: Text("No account? Register now")),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              }, child: Text("Test"))
            ],
          ),
        ),
      ),
    );
  }
  Future<http.Response> login(String email, String password) {
    return http.post(
      Uri.parse('https://rest-api-spring-ngeu.onrender.com/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }
}
