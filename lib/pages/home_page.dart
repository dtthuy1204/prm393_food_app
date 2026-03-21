import 'package:flutter/material.dart';
import 'package:prm393_food_app/components/my_current_location.dart';
import 'package:prm393_food_app/components/my_description_box.dart';
import 'package:prm393_food_app/components/my_food_tile.dart';
import 'package:prm393_food_app/components/my_tab_bar.dart';
import 'package:prm393_food_app/models/food.dart';
import 'package:prm393_food_app/models/restaurant.dart';
import 'package:prm393_food_app/pages/cart_page.dart';
import 'package:prm393_food_app/pages/food_page.dart';
import 'package:prm393_food_app/pages/login_page.dart';
import 'package:prm393_food_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: FoodCategory.values.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //lọc food theo category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  //list food theo từng tab
  List<Widget> _getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoryMenu.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final food = categoryMenu[index];

          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodPage(food: food)),
            ),
          );
        },
      );
    }).toList();
  }

  void _handleLogout() async {
  final confirm = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            "Logout",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );

  if (confirm == true) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }
}

  void _toggleTheme() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hello 👋",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartPage(),
                              ),
                            );
                          },
                        ),

                        IconButton(
                          icon: Icon(
                            Theme.of(context).brightness == Brightness.dark
                                ? Icons.light_mode
                                : Icons.dark_mode,
                          ),
                          onPressed: _toggleTheme,
                        ),

                        IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: _handleLogout,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        // 📍 location
                        MyCurrentLocation(),

                        const SizedBox(height: 10),

                        // 📄 description
                        const MyDescriptionBox(),

                        const SizedBox(height: 10),

                        // 🍔 tab
                        MyTabBar(tabController: _tabController),

                        const SizedBox(height: 10),

                        // 🍕 list
                        Expanded(
                          child: Consumer<Restaurant>(
                            builder: (context, restaurant, child) {
                              return TabBarView(
                                controller: _tabController,
                                children: _getFoodInThisCategory(
                                  restaurant.menu,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
