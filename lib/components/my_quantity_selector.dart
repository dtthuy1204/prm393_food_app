import 'package:flutter/material.dart';
import '../models/food.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Food food;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.food,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          // ➖ button
          _buildButton(
            icon: Icons.remove,
            onTap: onDecrement,
            color: Colors.grey.shade200,
            iconColor: Colors.black,
          ),

          const SizedBox(width: 10),

          // 🔢 quantity
          Text(
            quantity.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 10),

          // ➕ button
          _buildButton(
            icon: Icons.add,
            onTap: onIncrement,
            color: Colors.pink,
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: iconColor,
        ),
      ),
    );
  }
}