import 'package:flutter/material.dart';
import 'package:prm393_food_app/components/my_button.dart';
import 'package:prm393_food_app/components/my_textfield.dart';
import 'package:prm393_food_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  //text editing controllers
  final void Function()? onTap;
  const  LoginPage({
    super.key,
    required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login method
  void login(){
    /*
    fill out authentication logic
    */

    //navigate to home page
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.lock_open_rounded,
              size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 25),
            //message, app slogan
            Text(
              "Food Delivery App",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary, 
                ),
            ),
            const SizedBox(height: 25),
            //email textfield
            MyTextField(
              controller: emailController, 
              hintText: "Email", 
              obsureText: false,
              ),

              //password textfield
              const SizedBox(height: 10),
            //password textfield
            MyTextField(
              controller: passwordController, 
              hintText: "Password", 
              obsureText: true,
              ),

              const SizedBox(height: 10),
              //sign in button
              MyButton(
                text: "Sign In", 
                onTap: login,
              ),

              const SizedBox(height: 25),
              //not a member? register now
              Row(
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                    "Register now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ],
              )
          ],
        )
      )
    );
  }
}