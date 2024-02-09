import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final double grams;
  final String description;
  final String type;
  final String imageUrl;
  final double gst;
  final double otherCharges;
  final int likesCount;
  final int savesCount;

  Product({
    required this.id,
    required this.name,
    required this.grams,
    required this.description,
    required this.type,
    required this.imageUrl,
    required this.gst,
    required this.otherCharges,
    required this.likesCount,
    required this.savesCount,
  });

  factory Product.fromSnapshot(DocumentSnapshot snapshot) {
    return Product(
        id: snapshot.id,
        name: snapshot['name'],
        grams: snapshot['grams'],
        description: snapshot['description'],
        type: snapshot['type'],
        imageUrl: snapshot['image_url'],
        gst: snapshot['gst'],
        otherCharges: snapshot['otherCharges'],
        likesCount: snapshot['likesCount'],
        savesCount: snapshot['savesCount'],
    );
  }
}
