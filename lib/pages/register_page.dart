import 'package:flutter/material.dart';
import 'package:prm393_food_app/components/my_button.dart';
import 'package:prm393_food_app/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
   RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
              "Let's create an account for you!",
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
              //confirm password textfield
              MyTextField(
              controller: confirmPasswordController, 
              hintText: "Confirm Password", 
              obsureText: true,
              ),

              const SizedBox(height: 25),
              //sign up button
              MyButton(
                text: "Sign Up", 
                onTap: () {}
              ),

              const SizedBox(height: 25),
              //already a member? login now
              Row(
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                    "Login now",
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