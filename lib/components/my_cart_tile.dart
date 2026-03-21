import 'package:flutter/material.dart';
import 'package:prm393_food_app/components/my_quantity_selector.dart';
import 'package:prm393_food_app/models/cart_item.dart';
import 'package:prm393_food_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),

        child: Column(
          children: [

            // 🔹 main row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 🍔 image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    cartItem.food.imagePath,
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 12),

                // 📄 info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // food name
                      Text(
                        cartItem.food.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // price
                      Text(
                        "\$${cartItem.food.price}",
                        style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // quantity
                      QuantitySelector(
                        quantity: cartItem.quantity,
                        food: cartItem.food,
                        onDecrement: () {
                          restaurant.removeFromCart(cartItem);
                        },
                        onIncrement: () {
                          restaurant.addToCart(
                            cartItem.food,
                            cartItem.selectedAddons,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 🔹 addons
            if (cartItem.selectedAddons.isNotEmpty) ...[
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: cartItem.selectedAddons.map((addon) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${addon.name} (+\$${addon.price})",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}