import 'package:flutter/material.dart';
import 'package:prm393_food_app/components/my_button.dart';
import 'package:prm393_food_app/components/my_textfield.dart';
import 'package:prm393_food_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
   this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
  final _authService = AuthService();

  try {
    final cred = await _authService.signInWithEmailPassword(
      emailController.text,
      passwordController.text,
    );

    final user = cred.user;

    if (user != null) {
      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      final doc = await userRef.get();

      if (!doc.exists) {
        await userRef.set({
          'email': user.email,
          'role': 'user',
          'createdAt': DateTime.now(),
        });
      }
    }

  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(e.toString()),
      ),
    );
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    // icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fastfood_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // title
                    const Text(
                      "Welcome Back 🍔",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Login to continue",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
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

                    const SizedBox(height: 8),
                    const SizedBox(height: 20),

                    // login button (custom đẹp hơn)
                    GestureDetector(
                      onTap: login,
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
                            "Login",
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

                    // register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not a member? "),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Register now",
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