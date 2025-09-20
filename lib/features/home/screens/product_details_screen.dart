import 'package:flutter/material.dart';
import 'package:food_app/core/utils/hive_data_store/hive_data_store.dart';
import 'package:food_app/features/home/screens/widgets/adding_product_row.dart';
import 'package:food_app/features/models/product/product_models.dart';
import 'package:food_app/main.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Product food;

  const FoodDetailsScreen({Key? key, required this.food}) : super(key: key);

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  //-- variables
  HiveDataStore store = HiveDataStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        foregroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
        valueListenable: store.listenToProduct(),
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //-- product details
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 2)],
                            border: Border.all(color: Colors.grey, width: 2),
                          ),

                          //-- product image
                          child: Image.asset(widget.food.image, height: 200, fit: BoxFit.cover),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            //-- rating icon
                            Icon(Icons.star, color: Colors.orange, size: 22),
                            SizedBox(width: 4),

                            //-- rating
                            Text(
                              widget.food.rating.toStringAsFixed(1),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      //-- product name
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(widget.food.name, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                      ),

                      //-- product description
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(widget.food.description, style: TextStyle(fontSize: 17, color: Colors.grey[700])),
                      ),
                    ],
                  ),
                ),
              ),

              //-- product adding row
              ProductAddingRow(food: widget.food),
            ],
          );
        },
      ),
    );
  }
}
