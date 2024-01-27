import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String type;
  final String imageUrl;
  final int likesCount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.type,
    required this.imageUrl,
    required this.likesCount,
  });

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    return Product(
      id: snapshot.id,
      name: snapshot['name'],
      price: snapshot['price'],
      description: snapshot['description'],
      type: snapshot['type'],
      imageUrl: snapshot['image_url'],
      likesCount: snapshot['likesCount'],
    );
  }
}
