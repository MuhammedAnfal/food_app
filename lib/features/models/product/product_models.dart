import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'product_models.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  double price;

  @HiveField(4)
  String image; // Can store image path or base64 string

  @HiveField(5)
  double rating;

  @HiveField(6)
  int? quantity;

  Product({
    required this.id,
     this.quantity,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
  });

  //-- create new taks
  factory Product.create({
    String? id,
    required String? name,
    required String? description,
    required String? image,
    required double price,
    required double rating,
    int? quantity,
  }) => Product(
    id: Uuid().v1(),
    name: name ?? '',
    description: description ?? '',
    image: image.toString(),
    price: price.toDouble(),
    rating: rating,
    quantity: quantity
  );
}
