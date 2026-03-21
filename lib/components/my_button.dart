import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),

        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),

            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF7EB3),
                Color(0xFFFF758C),
              ],
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),

          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}