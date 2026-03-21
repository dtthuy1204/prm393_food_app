import 'package:flutter/material.dart';
import 'package:prm393_food_app/components/my_cart_tile.dart';
import 'package:prm393_food_app/models/restaurant.dart';
import 'package:prm393_food_app/pages/payment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.cart;

        return Scaffold(
          backgroundColor: Colors.transparent,

          body: Stack(
            children: [
              // 🌈 background
              Container(
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
              ),

              Column(
                children: [
                  // 🧾 AppBar custom
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "My Cart",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(16),
                                  ),
                                  title: const Text(
                                      'Clear all items?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        restaurant.clearCart();
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete_outline),
                          )
                        ],
                      ),
                    ),
                  ),

                  // 📦 cart content
                  Expanded(
                    child: userCart.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Your cart is empty",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            itemCount: userCart.length,
                            itemBuilder: (context, index) {
                              final cartItem =
                                  userCart[index];

                              return Padding(
                                padding:
                                    const EdgeInsets.only(
                                        bottom: 12),
                                child: MyCartTile(
                                    cartItem: cartItem),
                              );
                            },
                          ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),

              // 💳 checkout button (floating)
              if (userCart.isNotEmpty)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PaymentPage(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF9A9E),
                            Color(0xFFFAD0C4),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.pink.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Go to checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}