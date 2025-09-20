

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/hive_data_store/hive_data_store.dart';
import '../../../../core/utils/scaffold_service/scaffold_service.dart';
import '../../../models/product/product_models.dart';

class ProductAddingRow extends StatefulWidget {
  ProductAddingRow({super.key, required this.food});

  final Product food;

  @override
  State<ProductAddingRow> createState() => _ProductAddingRowState();
}

class _ProductAddingRowState extends State<ProductAddingRow> {
  //-- variables
  void checkProductIsAlreadyAdded({required List<Product> addedProducts, required Product product}) {
    bool found = false;

    for (var product in addedProducts) {
      if (product.name == widget.food.name) {
        product.quantity = (product.quantity ?? 0) + 1;
        product.save();
        found = true;
        break;
      }
    }
    if (!found) {
      store.addProduct(product: product);
    }
    SnackbarService.showSnackBar(context: context, message: 'Product Added Successfully', type: SnackbarType.success);
  }

  int quantity = 1;
  HiveDataStore store = HiveDataStore();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          //-- product amount
          Text(
            '₹${(widget.food.price).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
          ),

          //-- button to add product
          ElevatedButton.icon(
            onPressed: () {
              Product product = Product.create(
                description: widget.food.description,
                name: widget.food.name,
                image: widget.food.image,
                price: widget.food.price,
                rating: widget.food.rating,
                quantity: quantity,
              );
              checkProductIsAlreadyAdded(addedProducts: store.box.values.toList(), product: product);
            },

            //-- icon
            icon: Icon(Icons.shopping_cart),

            //-- add to cart text
            label: Text('Add to Cart'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}