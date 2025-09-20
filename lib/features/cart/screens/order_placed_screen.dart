import 'package:flutter/material.dart';
import 'package:food_app/core/utils/extension/size_extension.dart';
import 'package:food_app/features/auth/screens/widgets/custom_rounded_button.dart';
import 'package:food_app/features/home/screens/home_screen.dart';
import 'package:food_app/features/models/product/product_models.dart';

class OrderSuccessScreen extends StatelessWidget {
  final List<Product> products;
  final double totalAmount;

  const OrderSuccessScreen({super.key, required this.products, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide back button
        title: const Text('Order Placed'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success icon
              Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
              const SizedBox(height: 24),

              // Success message
              const Text(
                'Your order has been placed successfully!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              // Order details
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Order ID: ${products.map((product) => product.name).join(',')},',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Button to go back to home
              CustomRoundedButton(
                text: 'Back To Home',
                borderRadius: 20,
                buttonColor: Colors.blue.shade400,
                buttonHeight: context.height * 0.07,
                buttonWidth: context.width * 0.5,
                padding: EdgeInsets.only(top: 20),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
