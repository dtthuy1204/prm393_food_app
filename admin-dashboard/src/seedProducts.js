import { db } from "./firebase";
import { collection, addDoc } from "firebase/firestore";

const products = [
  // 🍔 BURGERS
  {
    name: "Burger Fillet Fish Cheese",
    description: "Crispy fish fillet served with melted cheese, fresh lettuce, and creamy tartar sauce in a soft bun.",
    price: 3.99,
    category: "burgers",
    imagePath: "/images/burgers/burger_1.png",
    addons: [
      { name: "Extra Cheese", price: 0.5 },
      { name: "Extra Fish Fillet", price: 1.5 },
      { name: "Tartar Sauce", price: 0.3 },
    ],
  },
  {
    name: "Double Beef Cheese Burger",
    description: "Two layers of juicy grilled beef patties with double melted cheese, fresh lettuce, tomato, and special house sauce.",
    price: 5.99,
    category: "burgers",
    imagePath: "/images/burgers/burger_2.png",
    addons: [
      { name: "Extra Cheese", price: 0.5 },
      { name: "Extra Beef Patty", price: 2.0 },
      { name: "Bacon", price: 1.0 },
    ],
  },
  {
    name: "Burger Big Mac",
    description:
          "Iconic burger with two beef patties, melted cheese, fresh lettuce, pickles, onions, and special Big Mac sauce in a sesame bun.",
    price: 4.49,
    category: "burgers",
    imagePath: "/images/burgers/burger_3.png",
    addons: [
      { name: "Extra Cheese", price: 0.5 },
      { name: "Extra Beef Patty", price: 2.0 },
      { name: "Big Mac Sauce", price: 1.0 },
    ],
  },
  {
    name: "Special Royal Beef Burger",
      description:
          "Premium grilled beef patty topped with rich melted cheese, fresh lettuce, tomato, caramelized onions, and royal special sauce.",
    price: 6.49,
    category: "burgers",
    imagePath: "/images/burgers/burger_4.png",
    addons: [
        { name: "Extra Cheese", price: 0.5 },
        { name: "Extra Beef Patty", price: 2.0 },
        { name: "Fried Egg", price: 0.8 },
    ],
  },
  {
    name: "Beef Burger Special Cheese",
      description:
          "Juicy grilled beef patty topped with special melted cheese, fresh lettuce, tomato, and our signature sauce.",
    price: 4.99,
    category: "burgers",
    imagePath: "/images/burgers/burger_5.png",
    addons: [
        { name: "Extra Cheese", price: 0.5 },
        { name: "Extra Beef Patty", price: 2.0 },
        { name: "Bacon", price: 1.0 },
    ]
  },

  // 🥗 SALADS
  {
    name: "Garden Salad With Vinegar Dressing",
      description:
          "Fresh mixed greens with tomatoes, cucumbers, carrots, and onions, served with light vinegar dressing.",
      price: 2.99,
    category: "salads",
    imagePath: "/images/salads/salad_1.png",
    addons: [
      { name: "Grilled Chicken", price: 1.5 },
      { name: "Boiled Egg", price: 0.7 },
      { name: "Extra Dressing", price: 0.3}
    ],
  },
  {
    name: "Shrimp Salad with Lime Creamy Dressing",
      description:
          "Fresh salad with juicy shrimp, mixed greens, tomatoes, cucumbers, and a creamy lime dressing.",
    price: 4.99,
    category: "salads",
    imagePath: "/images/salads/salad_2.png",
    addons: [
        { name: "Extra Shrimp", price: 2.0 },
        { name: "Avocado", price: 1.0 },
        { name: "Extra Dressing", price: 0.3 }
    ]
  },
  {
    name: "Signature Salad With Original Salad Cream",
      description:
          "Fresh mixed greens with tomatoes, cucumbers, carrots, and corn, served with our original creamy salad dressing.",
    price: 3.49,
    category: "salads",
    imagePath: "/images/salads/salad_3.png",
    addons: [
        { name: "Grilled Chicken", price: 1.5 },
        { name: "Boiled Egg", price: 0.7 },
        { name: "Extra Dressing", price: 0.3 }
    ]
  },

  {
    name: "Chicken Strip Salad With Thousand Island Dressing",
      description:
          "Crispy chicken strips served on fresh mixed greens with tomatoes, cucumbers, and classic Thousand Island dressing.",
    price: 4.49,
    category: "salads",
    imagePath: "/images/salads/salad_4.png",
    addons: [
        { name: "Extra Chicken Strips", price: 2.0 },
        { name: "Cheese", price: 1.0 },
        { name: "Extra Thousand Island Dressing", price: 0.3}
    ],
  },

  {
    name: "Classic Caesar's Salad With Caesar Dressing",
      description:
          "Crisp romaine lettuce with parmesan cheese, crunchy croutons, and classic Caesar dressing.",
    price: 3.99,
    category: "salads",
    imagePath: "/images/salads/salad_5.png",
    addons: [
        { name: "Grilled Chicken", price: 1.5 },
        { name: "Shrimp", price: 1.8 },
        { name: "Extra Caesar Dressing", price: 0.3 }
    ]
  },

  // 🍟 SIDES
  {
    name: "Pork Ribs",
      description:
          "Tender slow-cooked pork ribs glazed with rich barbecue sauce, served hot and juicy.",
      price: 6.99,
    category: "sides",
    imagePath: "/images/sides/side_1.png",
    addons: [
      { name: "Cheese Sauce", price: 0.5 },
      { name: "BBQ Sauce", price: 0.3 },
      {name: "Coleslaw", price: 0.80},
    ],
  },

  {
    name: "Bread Stick With Dipping Sauce",
      description:
          "Warm baked bread sticks served with a flavorful dipping sauce.",
    price: 1.99,
    category: "sides",
    imagePath: "/images/sides/side_2.png",
    addons: [
      { name: "Extra Dipping Sauce", price: 0.3 },
        { name: "Cheese Dip", price: 0.5 },
        { name: "Garlic Butter Dip", price: 0.4 }
    ],
  },

  {
    name: "Chicken Trio Platter With Korean Sauce",
      description:
          "A delicious platter of three styles of crispy chicken served with rich and spicy Korean sauce.",
    price: 7.99,
    category: "sides",
    imagePath: "/images/sides/side_3.png",
    addons: [
        { name: "Extra Korean Sauce", price: 0.5 },
        { name: "Ranch Dip", price: 0.4 },
        { name: "Coleslaw", price: 0.8 }
    ]
  },

  {
    name: "Cheese Garlic Bread",
      description:
          "Crispy garlic bread topped with melted cheese and aromatic garlic butter.",
    price: 2.49,
    category: "sides",
    imagePath: "/images/sides/side_4.png",
    addons: [
        { name: "Extra Cheese", price: 0.5 },
        { name: "Marinara Sauce", price: 0.3 },
        { name: "Ranch Dip", price: 0.4 }
    ]
  },

  {
    name: "French Fries",
      description:
          "Golden crispy French fries, lightly salted and freshly fried.",
    price: 1.99,
    category: "sides",
    imagePath: "/images/sides/side_5.png",
    addons: [
        { name: "Cheese Sauce", price: 0.5 },
        { name: "BBQ Sauce", price: 0.3 },
        { name: "Ranch Dip", price: 0.4 }
    ]
  },

  // 🍰 DESSERTS
  {
    name: "Sundae™ Ice Cream with Chocolate Sauce",
      description:
          "Smooth and creamy sundae ice cream topped with rich chocolate sauce for a classic sweet treat.",
      price: 2.99,
    category: "desserts",
    imagePath: "/images/desserts/desert_1.png",
    addons: [
      { name: "Extra Oreo Crumbs", price: 0.4 },
        { name: "Crushed Nuts", price: 0.5 },
        { name: "Whipped Cream", price: 0.3 }
    ],
  },

  {
    name: "Ice Cream Sundae™ with Strawberry Sauce",
      description:
          "Creamy sundae ice cream topped with sweet and refreshing strawberry sauce.",
    price: 2.99,
    category: "desserts",
    imagePath: "/images/desserts/desert_2.png",    
    addons: [
        { name: "Extra Strawberry Sauce", price: 0.4 },
        { name: "Crushed Nuts", price: 0.5 },
        { name: "Whipped Cream", price: 0.3 }
    ]
  },

  {
    name: "Green Tea Oreo™ Ice Cream",
      description:
          "Smooth green tea ice cream blended with crunchy Oreo™ cookie pieces for a rich and refreshing dessert.",
    price: 3.49,
    category: "desserts",
    imagePath: "/images/desserts/desert_3.png",
    addons: [
        { name: "Extra Oreo Crumbs", price: 0.4 },
        { name: "Whipped Cream", price: 0.3 },
        { name: "Chocolate Sauce", price: 0.5 }
    ]
  },

  {
    name: "Oreo™ Cake Cream",
      description:
          "Soft and creamy cake layered with rich cream and crunchy Oreo™ cookie pieces.",
    price: 3.99,
    category: "desserts",
    imagePath: "/images/desserts/desert_4.png",
    addons: [
        { name: "Extra Oreo Crumbs", price: 0.4 },
        { name: "Whipped Cream", price: 0.3 },
        { name: "Chocolate Sauce", price: 0.5 }
    ]
  },

  {
    name: "Ice Cream Cones",
      description:
          "Crispy cone filled with smooth and creamy ice cream, perfect for a classic treat.",
    price: 1.99,
    category: "desserts",
    imagePath: "/images/desserts/desert_5.png",
    addons: [
        { name: "Chocolate Dip", price: 0.5 },
        { name: "Sprinkles", price: 0.3 },
        { name: "Whipped Cream", price: 0.3 }
    ]
  },

  // 🥤 DRINKS
  {
    name: "Pepsi Can",
      description: "Chilled can of Pepsi, refreshing and fizzy soft drink.",
      price: 1.29,
    category: "drinks",
    imagePath: "/images/drinks/drink_1.png",
    addons: [
      { name: "Extra Ice", price: 0.0 },
        { name: "Lemon Slice", price: 0.2 },
        { name: "Large Size", price: 0.5 }
    ],
  },

  {
    name: "7Up Can",
      description: "Chilled can of 7Up, crisp lemon-lime flavored soft drink.",
    price: 1.29,
    category: "drinks",
    imagePath: "/images/drinks/drink_2.png",
    addons: [
        { name: "Extra Ice", price: 0.0 },
        { name: "Lemon Slice", price: 0.2 },
        { name: "Large Size", price: 0.5 }
    ]
  },

  {
    name: "Heineken Beer",
      description:
          "Chilled Heineken beer with a smooth, refreshing taste and light bitterness.",
    price: 2.99,
    category: "drinks",
    imagePath: "/images/drinks/drink_3.png",
    addons: [
        { name: "Lime Wedge", price: 0.2 },
        { name: "Extra Ice", price: 0.0 },
        { name: "Large Size", price: 0.5 }
    ]
  },

  {
    name: "Pepsi Lime 0 Calories",
      description:
          "Refreshing zero-calorie Pepsi with a zesty lime flavor, served chilled.",
    price: 1.29,
    category: "drinks",
    imagePath: "/images/drinks/drink_4.png",
    addons: [
        { name: "Extra Ice", price: 0.0 },
        { name: "Lemon Slice", price: 0.2 },
        { name: "Large Size", price: 0.5 }
    ]
  },
  {
    name: "Mirinda Soda Cream Can",
      description:
          "Chilled can of Mirinda Soda Cream with a smooth, sweet, and creamy citrus flavor.",
    price: 1.29,
    category: "drinks",
    imagePath: "/images/drinks/drink_5.png",
    addons: [
        { name: "Extra Ice", price: 0.0 },
        { name: "Lemon Slice", price: 0.2 },
        { name: "Large Size", price: 0.5}
    ]
  }
];

export const seedProducts = async () => {
  try {
    for (let product of products) {
      await addDoc(collection(db, "products"), product);
    }
    console.log("✅ Seed products DONE");
  } catch (error) {
    console.error("❌ Seed error:", error);
  }
};