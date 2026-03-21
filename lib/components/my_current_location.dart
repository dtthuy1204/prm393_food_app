import 'package:flutter/material.dart';
import 'package:prm393_food_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  MyCurrentLocation({super.key});

  final textController = TextEditingController();

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("Your location"),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: "Enter address...",
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              String newAddress = textController.text;
              context
                  .read<Restaurant>()
                  .updateDeliveryAddress(newAddress);
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openLocationSearchBox(context),

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),

        child: Row(
          children: [

            // 📍 icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 12),

            // 📄 text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Deliver now",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 2),

                  Consumer<Restaurant>(
                    builder: (context, restaurant, child) {
                      return Text(
                        restaurant.deliveryAddress,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ],
              ),
            ),

            // ⬇️ arrow
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}