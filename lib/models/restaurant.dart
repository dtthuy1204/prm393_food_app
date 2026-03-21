import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prm393_food_app/models/cart_item.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  //list of food menu
  final List<Food> _menu = [
    //burgers
    Food(
      name: "Burger Fillet Fish Cheese",
      description:
          "Crispy fish fillet served with melted cheese, fresh lettuce, and creamy tartar sauce in a soft bun.",
      imagePath: "lib/images/burgers/burger_1.png",
      price: 3.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Cheese", price: 0.50),
        Addon(name: "Extra Fish Fillet", price: 1.50),
        Addon(name: "Tartar Sauce", price: 0.30),
      ],
    ),
    Food(
      name: "Double Beef Cheese Burger",
      description:
          "Two layers of juicy grilled beef patties with double melted cheese, fresh lettuce, tomato, and special house sauce.",
      imagePath: "lib/images/burgers/burger_2.png",
      price: 5.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Cheese", price: 0.50),
        Addon(name: "Extra Beef Patty", price: 2.00),
        Addon(name: "Bacon", price: 1.00),
      ],
    ),
    Food(
      name: "Burger Big Mac",
      description:
          "Iconic burger with two beef patties, melted cheese, fresh lettuce, pickles, onions, and special Big Mac sauce in a sesame bun.",
      imagePath: "lib/images/burgers/burger_3.png",
      price: 4.49,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Cheese", price: 0.50),
        Addon(name: "Extra Beef Patty", price: 2.00),
        Addon(name: "Big Mac Sauce", price: 0.30),
      ],
    ),
    Food(
      name: "Special Royal Beef Burger",
      description:
          "Premium grilled beef patty topped with rich melted cheese, fresh lettuce, tomato, caramelized onions, and royal special sauce.",
      imagePath: "lib/images/burgers/burger_4.png",
      price: 6.49,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Cheese", price: 0.50),
        Addon(name: "Extra Beef Patty", price: 2.00),
        Addon(name: "Fried Egg", price: 0.80),
      ],
    ),

    Food(
      name: "Beef Burger Special Cheese",
      description:
          "Juicy grilled beef patty topped with special melted cheese, fresh lettuce, tomato, and our signature sauce.",
      imagePath: "lib/images/burgers/burger_5.png",
      price: 4.99,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra Cheese", price: 0.50),
        Addon(name: "Bacon", price: 1.00),
        Addon(name: "Extra Beef Patty", price: 2.00),
      ],
    ),

    //salads
    Food(
      name: "Garden Salad With Vinegar Dressing",
      description:
          "Fresh mixed greens with tomatoes, cucumbers, carrots, and onions, served with light vinegar dressing.",
      imagePath: "lib/images/salads/salad_1.png",
      price: 2.99,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Grilled Chicken", price: 1.50),
        Addon(name: "Boiled Egg", price: 0.70),
        Addon(name: "Extra Dressing", price: 0.30),
      ],
    ),
    Food(
      name: "Shrimp Salad with Lime Creamy Dressing",
      description:
          "Fresh salad with juicy shrimp, mixed greens, tomatoes, cucumbers, and a creamy lime dressing.",
      imagePath: "lib/images/salads/salad_2.png",
      price: 4.49,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra Shrimp", price: 1.50),
        Addon(name: "Avocado", price: 0.80),
        Addon(name: "Extra Lime Dressing", price: 0.30),
      ],
    ),
    Food(
      name: "Signature Salad With Original Salad Cream",
      description:
          "Fresh mixed greens with tomatoes, cucumbers, carrots, and corn, served with our original creamy salad dressing.",
      imagePath: "lib/images/salads/salad_3.png",
      price: 3.49,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Grilled Chicken", price: 1.50),
        Addon(name: "Boiled Egg", price: 0.70),
        Addon(name: "Extra Salad Cream", price: 0.30),
      ],
    ),
    Food(
      name: "Chicken Strip Salad With Thousand Island Dressing",
      description:
          "Crispy chicken strips served on fresh mixed greens with tomatoes, cucumbers, and classic Thousand Island dressing.",
      imagePath: "lib/images/salads/salad_4.png",
      price: 4.29,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra Chicken Strips", price: 1.50),
        Addon(name: "Cheese", price: 0.50),
        Addon(name: "Extra Thousand Island Dressing", price: 0.30),
      ],
    ),
    Food(
      name: "Classic Caesar's Salad With Caesar Dressing",
      description:
          "Crisp romaine lettuce with parmesan cheese, crunchy croutons, and classic Caesar dressing.",
      imagePath: "lib/images/salads/salad_5.png",
      price: 3.99,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Grilled Chicken", price: 1.50),
        Addon(name: "Shrimp", price: 1.80),
        Addon(name: "Extra Caesar Dressing", price: 0.30),
      ],
    ),

    //sides
    Food(
      name: "Pork Ribs",
      description:
          "Tender slow-cooked pork ribs glazed with rich barbecue sauce, served hot and juicy.",
      imagePath: "lib/images/sides/side_1.png",
      price: 6.99,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Extra BBQ Sauce", price: 0.30),
        Addon(name: "French Fries", price: 1.20),
        Addon(name: "Coleslaw", price: 0.80),
      ],
    ),
    Food(
      name: "Bread Stick With Dipping Sauce",
      description:
          "Warm baked bread sticks served with a flavorful dipping sauce.",
      imagePath: "lib/images/sides/side_2.png",
      price: 2.49,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Cheese Dip", price: 0.50),
        Addon(name: "Garlic Butter", price: 0.40),
        Addon(name: "Extra Dipping Sauce", price: 0.30),
      ],
    ),
    Food(
      name: "Chicken Trio Platter With Korean Sauce",
      description:
          "A delicious platter of three styles of crispy chicken served with rich and spicy Korean sauce.",
      imagePath: "lib/images/sides/side_3.png",
      price: 7.99,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Extra Korean Sauce", price: 0.40),
        Addon(name: "French Fries", price: 1.20),
        Addon(name: "Coleslaw", price: 0.80),
      ],
    ),
    Food(
      name: "Cheese Garlic Bread",
      description:
          "Crispy garlic bread topped with melted cheese and aromatic garlic butter.",
      imagePath: "lib/images/sides/side_4.png",
      price: 2.99,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Extra Cheese", price: 0.50),
        Addon(name: "Garlic Butter", price: 0.40),
        Addon(name: "Cheese Dip", price: 0.50),
      ],
    ),
    Food(
      name: "French Fries",
      description:
          "Golden crispy French fries, lightly salted and freshly fried.",
      imagePath: "lib/images/sides/side_5.png",
      price: 1.99,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Cheese Sauce", price: 0.50),
        Addon(name: "BBQ Sauce", price: 0.30),
        Addon(name: "Chili Powder", price: 0.20),
      ],
    ),

    //desserts
    Food(
      name: "Sundae™ Ice Cream with Chocolate Sauce",
      description:
          "Smooth and creamy sundae ice cream topped with rich chocolate sauce for a classic sweet treat.",
      imagePath: "lib/images/desserts/desert_1.png",
      price: 2.29,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra Chocolate Sauce", price: 0.30),
        Addon(name: "Whipped Cream", price: 0.40),
        Addon(name: "Crushed Nuts", price: 0.50),
      ],
    ),
    Food(
      name: "Ice Cream Sundae™ with Strawberry Sauce",
      description:
          "Creamy sundae ice cream topped with sweet and refreshing strawberry sauce.",
      imagePath: "lib/images/desserts/desert_2.png",
      price: 2.29,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra Strawberry Sauce", price: 0.30),
        Addon(name: "Whipped Cream", price: 0.40),
        Addon(name: "Crushed Nuts", price: 0.50),
      ],
    ),
    Food(
      name: "Green Tea Oreo™ Ice Cream",
      description:
          "Smooth green tea ice cream blended with crunchy Oreo™ cookie pieces for a rich and refreshing dessert.",
      imagePath: "lib/images/desserts/desert_3.png",
      price: 2.59,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra Oreo™ Crumbs", price: 0.40),
        Addon(name: "Chocolate Sauce", price: 0.30),
        Addon(name: "Whipped Cream", price: 0.40),
      ],
    ),
    Food(
      name: "Oreo™ Cake Cream",
      description:
          "Soft and creamy cake layered with rich cream and crunchy Oreo™ cookie pieces.",
      imagePath: "lib/images/desserts/desert_4.png",
      price: 2.99,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra Oreo™ Crumbs", price: 0.40),
        Addon(name: "Chocolate Sauce", price: 0.30),
        Addon(name: "Whipped Cream", price: 0.40),
      ],
    ),
    Food(
      name: "Ice Cream Cones",
      description:
          "Crispy cone filled with smooth and creamy ice cream, perfect for a classic treat.",
      imagePath: "lib/images/desserts/desert_5.png",
      price: 1.49,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Chocolate Dip", price: 0.30),
        Addon(name: "Sprinkles", price: 0.20),
        Addon(name: "Extra Scoop", price: 0.80),
      ],
    ),

    //drinks
    Food(
      name: "Pepsi Can",
      description: "Chilled can of Pepsi, refreshing and fizzy soft drink.",
      imagePath: "lib/images/drinks/drink_1.png",
      price: 1.29,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra Ice", price: 0.00),
        Addon(name: "Lemon Slice", price: 0.20),
        Addon(name: "Large Size", price: 0.50),
      ],
    ),
    Food(
      name: "7Up Can",
      description: "Chilled can of 7Up, crisp lemon-lime flavored soft drink.",
      imagePath: "lib/images/drinks/drink_2.png",
      price: 1.29,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra Ice", price: 0.00),
        Addon(name: "Lemon Slice", price: 0.20),
        Addon(name: "Large Size", price: 0.50),
      ],
    ),
    Food(
      name: "Heineken Beer",
      description:
          "Chilled Heineken beer with a smooth, refreshing taste and light bitterness.",
      imagePath: "lib/images/drinks/drink_3.png",
      price: 2.49,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra Ice", price: 0.00),
        Addon(name: "Lime Slice", price: 0.20),
        Addon(name: "Beer Mug", price: 0.50),
      ],
    ),
    Food(
      name: "Pepsi Lime 0 Calories",
      description:
          "Refreshing zero-calorie Pepsi with a zesty lime flavor, served chilled.",
      imagePath: "lib/images/drinks/drink_4.png",
      price: 1.39,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra Ice", price: 0.00),
        Addon(name: "Lime Slice", price: 0.20),
        Addon(name: "Large Size", price: 0.50),
      ],
    ),
    Food(
      name: "Mirinda Soda Cream Can",
      description:
          "Chilled can of Mirinda Soda Cream with a smooth, sweet, and creamy citrus flavor.",
      imagePath: "lib/images/drinks/drink_5.png",
      price: 1.29,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra Ice", price: 0.00),
        Addon(name: "Lemon Slice", price: 0.20),
        Addon(name: "Large Size", price: 0.50),
      ],
    ),
  ];

  //user cart
  final List<CartItem> _cart = [];

  //delivery address (which user can change/update)
  String _deliveryAddress = "123 Main St";

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  //add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    //implementation
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      bool isSameAddons = ListEquality().equals(
        item.selectedAddons,
        selectedAddons,
      );
      return isSameFood && isSameAddons;
    });

    //if item already in cart, increase quantity
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectedAddons: selectedAddons));
    }
    notifyListeners();
  }

  //remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  //get total price of cart
  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  //get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  //clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

//update delivery address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  /*

  H E L P E R S

  */

  //generate a receipt
  String displayCartReceipt(){
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt:");
    receipt.writeln();

    //format the date to include up to seconds only
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-----------");

    for (final cartItem in _cart) {
      receipt.writeln(
        "${cartItem.food.name} x ${cartItem.quantity} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt.writeln("  Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln("-----------");
    }

    receipt.writeln("-----------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivering to: $deliveryAddress");
    return receipt.toString();
  }

  //format double value into money
 String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  //format list of addons into a string summary
  String _formatAddons(List<Addon> addons) {
    if (addons.isEmpty) return "No Add-ons";
    return addons.map((addon) => "${addon.name} (${_formatPrice(addon.price)})").join(", ");
  }
}
