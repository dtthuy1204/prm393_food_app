import 'package:flutter/material.dart';
import 'package:prm393_food_app/services/auth/auth_service.dart';
import 'package:prm393_food_app/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void register() async {
  if (passwordController.text != confirmPasswordController.text) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Passwords do not match!"),
      ),
    );
    return;
  }

  try {
    // 🔥 tạo user
    final cred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    // 🔥 lưu vào Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(cred.user!.uid)
        .set({
      'email': emailController.text,
      'role': 'user',
      'createdAt': DateTime.now(),
    });

  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 🌈 gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFDEE9),
              Color(0xFFB5FFFC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🍩 icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.icecream_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Create Account ✨",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Join us and start ordering 🍟",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 24),

                    // email
                    MyTextField(
                      controller: emailController,
                      hintText: "Email",
                      obsureText: false,
                    ),

                    const SizedBox(height: 12),

                    // password
                    MyTextField(
                      controller: passwordController,
                      hintText: "Password",
                      obsureText: true,
                    ),

                    const SizedBox(height: 12),

                    // confirm password
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      obsureText: true,
                    ),

                    const SizedBox(height: 20),

                    // 🎨 sign up button
                    GestureDetector(
                      onTap: register,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFF9A9E),
                              Color(0xFFFAD0C4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // login redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Login now",
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}