import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {

  var userEmail = TextEditingController();
  var userPassword = TextEditingController();
  var firstName = TextEditingController();
  var lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Page"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              TextField(controller: firstName, decoration: InputDecoration(hintText: "First Name"),),
              SizedBox(height: 8,),
              TextField(controller: lastName, decoration: InputDecoration(hintText: "Last Name"),),
              SizedBox(height: 8,),
              TextField(controller: userEmail, keyboardType: TextInputType.emailAddress,decoration: InputDecoration(hintText: "Email"),),
              SizedBox(height: 8),
              TextField(controller: userPassword, obscureText: true,decoration: InputDecoration(hintText: "Password"),),
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
                    print(firstName.text);
                    print(lastName.text);
                    register(userEmail.text, userPassword.text, firstName.text, lastName.text).then((value) {
                      print("Success");
                      print(value);
                      print(value.body);
                    }).catchError((e){
                      print(e);
                    });
                  }, child: Text("Register")),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
  Future<http.Response> register(String email, String password, String firstName, String lastName) {
    return http.post(
      Uri.parse('https://rest-api-spring-ngeu.onrender.com/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName
      }),
    );
  }
}
