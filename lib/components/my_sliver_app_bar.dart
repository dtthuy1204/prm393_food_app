import 'package:flutter/material.dart';
import 'package:prm393_food_app/pages/cart_page.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
    });

 @override
Widget build(BuildContext context) {
  return SliverAppBar(
    expandedHeight: 300,
    collapsedHeight: 100,
    pinned: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,

    // 🛒 cart button đẹp hơn
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),

            // 🔴 badge
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  "2", // TODO: dynamic cart count
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],

    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,

      // 🎨 title đẹp hơn
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          child: title,
        ),
      ),

      // 🌈 background
      background: Stack(
        fit: StackFit.expand,
        children: [

          // gradient nền
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

          // nội dung (location + description + tab)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 60),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: child,
            ),
          ),
        ],
      ),
    ),
  );
}
}