import 'package:flutter/foundation.dart';
import 'package:food_app/features/models/product/product_models.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataStore {
  static const boxName = 'products';


  Box<Product> get box => Hive.box<Product>(boxName);

  Future<void> addProduct({required Product product}) async {
    await box.put(product.id, product);
  }

  Future<Product?> getProduct({required String id}) async {
    return box.get(id);
  }

  Future<void> updateProduct({required Product product}) async {
    await box.put(product.id, product);
  }

  Future<void> deleteProduct({required Product product}) async {
    await box.delete(product.id);
  }

  ValueListenable<Box<Product>> listenToProduct() => box.listenable();
}
