import 'package:flutter/material.dart';
import 'package:food_app/core/constants/string_constants.dart';
import 'package:food_app/core/utils/extension/size_extension.dart';
import 'package:food_app/core/utils/hive_data_store/hive_data_store.dart';
import 'package:food_app/core/utils/scaffold_service/scaffold_service.dart';
import 'package:food_app/features/auth/screens/widgets/custom_rounded_button.dart';
import 'package:food_app/features/cart/screens/order_placed_screen.dart';
import 'package:food_app/features/models/product/product_models.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  //-- variables
  double total = 0;

  calculateTotalAmount({required List<Product> addedProducts}) {
    for (var product in addedProducts) {
      total += product.price * (product.quantity ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    //-- accessing hive
    final HiveDataStore store = HiveDataStore();
    return Scaffold(
      appBar: AppBar(title: Text("Checkout"), backgroundColor: Colors.grey.shade100),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: store.listenToProduct(),
          builder: (context, value, child) {
            calculateTotalAmount(addedProducts: value.values.toList());
            final products = value.values.toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Summary", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),

                //-- checking product are there
                if (products.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Center(
                      child: Text(
                        'Data is Empty',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                if(value.isNotEmpty)    Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: context.width,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: context.height * 0.7,
                            width: context.width * 0.9,
                            child: ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  height: context.height * 0.1,
                                  decoration: BoxDecoration(color: Colors.blue.shade300, borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Leading (image or icon)
                                      product.image.isNotEmpty
                                          ? Image.asset(product.image, width: 50, height: 50)
                                          : const Icon(Icons.fastfood, size: 40),
                                      const SizedBox(width: 12),

                                      // Title & Subtitle
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                product.name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Expanded(
                                              child: SizedBox(
                                                width: context.width * 0.4,
                                                child: Text(
                                                  product.description,

                                                  style: const TextStyle(fontSize: 14, color: Colors.white),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Trailing (price)
                                      Column(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Price",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "₹${product.price.toStringAsFixed(2)}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                   Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Qty",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${product.quantity}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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

                //-- proceed button
                if(value.isNotEmpty)   CustomRoundedButton(
                  buttonHeight: context.height * 0.08,
                  borderRadius: 25,
                  buttonColor: Colors.blue.shade300,
                  buttonWidth: context.width,
                  text: '${StringConstants.proceedText} ₹$total',
                  onPressed: () {
                    SnackbarService.showSnackBar(
                      context: context,
                      message: 'Order placed successfully',
                      type: SnackbarType.success,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSuccessScreen(products: value.values.toList(), totalAmount: total),
                      ),
                    );
                    value.clear();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
