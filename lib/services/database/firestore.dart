import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prm393_food_app/models/cart_item.dart';

class FirestoreService {
  //get collection of orders
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  //save order to db
  Future<void> saveOrderToDatabase({
  required List<CartItem> cart,
  required double totalPrice,
  required String address,
}) async {
  await orders.add({
    'date': DateTime.now(),
    'address': address,
    'totalPrice': totalPrice,
    'status': 'pending',
    'items': cart.map((item) => {
      'name': item.food.name,
      'price': item.food.price,
      'quantity': item.quantity,
    }).toList(),
  });
}
}