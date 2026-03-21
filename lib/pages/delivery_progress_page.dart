import 'package:flutter/material.dart';
import 'package:prm393_food_app/components/my_receipt.dart';
import 'package:prm393_food_app/models/restaurant.dart';
import 'package:prm393_food_app/services/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();

    final restaurant = context.read<Restaurant>();

    db.saveOrderToDatabase(
      cart: restaurant.cart,
      totalPrice: restaurant.getTotalPrice(),
      address: restaurant.deliveryAddress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          // 🌈 background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Column(
            children: [
              // 🚴 header
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "Delivery in progress",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 📦 receipt card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const SizedBox(
                      height: double.infinity,
                      child: MyReceipt(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 120),
            ],
          ),

          // 🚗 driver bottom card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNavBar(context),
          ),
        ],
      ),
    );
  }

  // 🚗 driver card UI xịn hơn
  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // 👤 avatar
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),

          const SizedBox(width: 12),

          // 📋 info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Donald Trump",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text("Your driver", style: TextStyle(color: Colors.grey)),
            ],
          ),

          const Spacer(),

          // 💬 actions
          Row(
            children: [
              _buildActionButton(icon: Icons.message, color: Colors.blue),
              const SizedBox(width: 10),
              _buildActionButton(icon: Icons.call, color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  // 🔘 reusable button
  Widget _buildActionButton({required IconData icon, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: IconButton(onPressed: () {}, icon: Icon(icon), color: color),
    );
  }
}
