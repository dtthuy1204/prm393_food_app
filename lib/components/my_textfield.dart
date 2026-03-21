import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),

        child: TextField(
          controller: controller,
          obscureText: obsureText,
          style: const TextStyle(fontSize: 14),

          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),

            border: InputBorder.none,

            // 👇 optional icon auto detect
            prefixIcon: Icon(
              hintText.toLowerCase().contains("password")
                  ? Icons.lock
                  : Icons.email,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}