import 'package:final_project_user_app/widgets/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  var userEmail = TextEditingController();
  var userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"),),
      body: Container(
        width: 200,
        height: 200,
        child: Center(
          child: Column(
            children: [
              TextField(controller: userEmail, decoration: InputDecoration(hintText: "Email"),),
              SizedBox(height: 8),
              TextField(controller: userPassword, decoration: InputDecoration(hintText: "Password"),),
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
              }, child: Text("Login")),
              SizedBox(height: 8),
              TextButton(
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              }, child: Text("No account? Register now"))
            ],
          ),
        ),
      ),
    );
  }
}
