import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:prm393_food_app/pages/delivery_progress_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Confirm payment'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Card: $cardNumber'),
                Text('Expiry: $expiryDate'),
                Text('Name: $cardHolderName'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const DeliveryProgressPage(),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Payment failed'),
          content: const Text(
              'Please check your card information and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
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

          Column(
            children: [
              // 🧾 appbar custom
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                            Icons.arrow_back_ios_new_rounded),
                        onPressed: () =>
                            Navigator.pop(context),
                      ),
                      const Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 📦 content
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // 💳 card preview
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: CreditCardWidget(
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          showBackView: isCvvFocused,
                          onCreditCardWidgetChange: (_) {},
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 📝 form card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              Colors.white.withOpacity(0.95),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: CreditCardForm(
                          formKey: formKey,
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          onCreditCardModelChange:
                              (data) {
                            setState(() {
                              cardNumber =
                                  data.cardNumber;
                              expiryDate =
                                  data.expiryDate;
                              cardHolderName =
                                  data.cardHolderName;
                              cvvCode = data.cvvCode;
                              isCvvFocused =
                                  data.isCvvFocused;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 💸 PAY BUTTON
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: userTappedPay,
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
                    "Pay now",
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