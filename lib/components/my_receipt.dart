import 'package:flutter/material.dart';
import 'package:prm393_food_app/models/restaurant.dart';
import 'package:prm393_food_app/pages/home_page.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // 🔝 phần cố định
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            size: 40,
            color: Colors.green,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          "Order Confirmed",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          "Thanks for your order!",
          style: TextStyle(color: Colors.grey),
        ),

        const SizedBox(height: 12),

        // 🔥 QUAN TRỌNG: phần receipt scroll
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Consumer<Restaurant>(
              builder: (context, restaurant, child) {
                return SingleChildScrollView(
                  child: Text(
                    restaurant.displayCartReceipt(),
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 12),

        // 🚚 delivery time
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time, color: Colors.pink),
              SizedBox(width: 6),
              Text(
                "Delivery: 4:10 PM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // 🔙 button
        GestureDetector(
          onTap: () => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => const HomePage()),
  (route) => false,
),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF9A9E),
                  Color(0xFFFAD0C4),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                "Back to Home",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}