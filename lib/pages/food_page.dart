import 'package:flutter/material.dart';
import 'package:prm393_food_app/components/my_button.dart';
import 'package:prm393_food_app/models/food.dart';
import 'package:prm393_food_app/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddons = {};

   FoodPage({super.key, required this.food}){
    //initialize selectedAddons map with false values
    for (Addon addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
   }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {

  //methid to add food to cart
  void addToCart(Food food, Map<Addon, bool> selectedAddons) {
    //close the food page
    Navigator.pop(context);

    //format selected addons into a list
    List<Addon> currentSelectedAddons = [];
    for (Addon addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentSelectedAddons.add(addon);
      }
    }
    //add to cart
    context.read<Restaurant>().addToCart(food, currentSelectedAddons);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      //scaffold UI
      Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //food image
            Image.asset(widget.food.imagePath),
        
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //food name
                  Text(widget.food.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
        
                      //food price
                  Text('\$${widget.food.price}',
                  style:  TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      )),
        
                      const SizedBox(height: 10),
        
                  //food description
                  Text(widget.food.description),
        
                  const SizedBox(height: 10),
        
                  Divider(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
        
                  //addons
                  Text(
                    "Add-ons",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
        
                  const SizedBox(height: 10),
              
                  Container(
                    decoration: BoxDecoration(border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(8),
                      ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: widget.food.availableAddons.length,
                      itemBuilder: (context, index) {
                        //get individual addon
                        Addon addon = widget.food.availableAddons[index];
                                
                        //return checkbox UI
                        return CheckboxListTile(
                          title: Text(addon.name),
                          subtitle: Text('\$${addon.price}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          ),
                          value: widget.selectedAddons[addon],
                          onChanged: (bool? value) {
                            setState((){
                              widget.selectedAddons[addon] = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        
            //button -> add to cart
            MyButton(
              onTap: () => addToCart(widget.food, widget.selectedAddons),
              text: "Add to cart",
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    ),


      //back button
      SafeArea(child: Opacity(
        opacity: 0.6,
        child: Container(
          margin: const EdgeInsets.only(left: 25),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
            ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      ),
    ],
    );
  }
}
