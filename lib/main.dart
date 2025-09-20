import 'package:flutter/material.dart';
import 'package:food_app/features/auth/screens/login_screen.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/utils/hive_data_store/hive_data_store.dart';
import 'features/home/screens/home_screen.dart';
import 'features/models/product/product_models.dart';

Future<void> main() async {
  //-- initializing hive
 await Hive.initFlutter();

  await Hive.openBox<Product>('products');
  //-- registering hive adapter
  Hive.registerAdapter(ProductAdapter());
 await Hive.openBox('settings');
 final settingsBox = Hive.box('settings');
 final isLoggedIn = settingsBox.get('isLoggedIn', defaultValue: false);

 runApp(BaseWidget(child: MyApp(isLoggedIn: isLoggedIn,)));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade300,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:isLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}

class BaseWidget extends InheritedWidget {

  BaseWidget({super.key, required super.child});

  final HiveDataStore dataStore = HiveDataStore();

  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancestor widget of the base widget type');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw false;
  }
}

