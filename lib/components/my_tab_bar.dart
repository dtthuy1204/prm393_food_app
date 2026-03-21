import 'package:flutter/material.dart';
import 'package:prm393_food_app/models/food.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;

  const MyTabBar({super.key, required this.tabController});

  List<Tab> _buildCategoryTabs() {
    return FoodCategory.values.map((category) {
      String name = category.toString().split('.').last;

      return Tab(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),

      child: TabBar(
        controller: tabController,
        tabs: _buildCategoryTabs(),
        isScrollable: true,

        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFF9A9E),
              Color(0xFFFAD0C4),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),

        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        dividerColor: Colors.transparent,
      ),
    );
  }
}