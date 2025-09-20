import 'package:flutter/material.dart';
import 'package:food_app/core/constants/image_constants.dart';
import 'package:food_app/core/utils/extension/size_extension.dart';
import 'package:food_app/features/cart/screens/checkout_screen.dart';
import 'package:food_app/features/home/screens/product_details_screen.dart';
import 'package:food_app/features/models/product/product_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> products = [
    Product(

      id: '1',
      name: 'Loaded Fries',
      description: 'vey special,tasty',
      price: 70,
      image: ImageConstants.pizzaImage,
      rating: 4,
    ),
    Product(
      id: '2',
      name: 'Cake',
      description: 'pizza a affordable prize',
      price: 35,
      image: ImageConstants.cakeImage,
      rating: 4,
    ),
    Product(
      id: '2',
      name: 'Pizza',
      description: 'pizza a affordable prize',
      price: 35,
      image: ImageConstants.loadedFries,
      rating: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [

          //-- shopping cart icon
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(),)),
                child: Icon(Icons.shopping_cart,)),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [

                //-- welcome text
                Row(
                  children: [
                    Text(
                      'Welcome Anshik',
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
            
                Row(
                  children: [
                    Text(
                      'Food At Your Finger',
                      style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.height * 0.7,
                  width: context.width * 0.95,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 230),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodDetailsScreen(
                                food: products[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsetsGeometry.all(5),
                          height: context.height * 0.07,
                          width: context.width * 0.8,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(

                                //-- product image
                                children: [
                                  Image.asset(products[index].image, height: context.height * 0.12, fit: BoxFit.contain),

                                 //-- product
                                  //-- product name

                                  Row(
                                    children: [
                                      Text(
                                        'name: ',
                                        style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                      ),


                                      Text(
                                        products[index].name,
                                        style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),

                                  //-- product price
                                  Row(
                                    children: [

                                      Text(
                                        'Price: ₹',
                                        style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        products[index].price.toString(),
                                        style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  //-- product rating

                                  Row(
                                    children: [
                                      Text(
                                        'Rating: ',
                                        style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        products[index].rating.toString(),
                                        style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
    );
  }
}
