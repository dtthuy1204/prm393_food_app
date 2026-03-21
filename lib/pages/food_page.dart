import 'package:flutter/material.dart';
import 'package:prm393_food_app/models/food.dart';
import 'package:prm393_food_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

  FoodPage({super.key, required this.food}) {
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    Navigator.pop(context);

    List<Addon> currentSelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentSelectedAddons.add(addon);
      }
    }

    context.read<Restaurant>().addToCart(food, currentSelectedAddons);
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
                colors: [
                  Color(0xFFFFDEE9),
                  Color(0xFFB5FFFC),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 📱 main content
          Column(
            children: [
              // 🍔 image + back button
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      widget.food.imagePath,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // overlay gradient
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),

                  // back button
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 📦 content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name + price
                        Text(
                          widget.food.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          '\$${widget.food.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.pink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          widget.food.description,
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Add-ons",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // addons list đẹp hơn
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.food.availableAddons.length,
                          itemBuilder: (context, index) {
                            Addon addon =
                                widget.food.availableAddons[index];

                            bool isSelected =
                                widget.selectedAddons[addon] ?? false;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.selectedAddons[addon] =
                                      !isSelected;
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.pink.shade50
                                      : Colors.grey.shade100,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.pink
                                        : Colors.transparent,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(addon.name),
                                    Text(
                                      '\$${addon.price}',
                                      style: const TextStyle(
                                        color: Colors.pink,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 🛒 add to cart button (fixed bottom)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () =>
                  addToCart(widget.food, widget.selectedAddons),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF9A9E),
                      Color(0xFFFAD0C4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Add to cart",
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
  }
}