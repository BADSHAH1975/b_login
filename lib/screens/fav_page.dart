import 'package:b_sell/appcolors.dart';
import 'package:b_sell/models/product.dart';
import 'package:b_sell/screens/product/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  List<String> products = List.generate(5, (index) => 'Product $index');
  bool isLoading = false;
  // ScrollController _scrollController = ScrollController();

  Future<Product> fetchProductDetails(String productId) async {
    DocumentSnapshot productSnapshot = await FirebaseFirestore.instance.collection('products').doc(productId).get();

    return Product(
      id: productId,
      name: productSnapshot['name'],
      price: productSnapshot['price'].toDouble(),
      description: productSnapshot['description'],
      type: productSnapshot['type'],
      imageUrl: productSnapshot['image_url'],
      likes: productSnapshot['likes'],
    );
  }

  Future<List<Product>> fetchFavoriteProductDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      CollectionReference savedRef = userDocRef.collection('saved');
      QuerySnapshot snapshot = await savedRef.get();

      List<String> favoriteProductIds = snapshot.docs.map((savedID) => savedID.id).toList();

      List<Future<Product>> productDetailsFutures = favoriteProductIds.map((productId) {
        return fetchProductDetails(productId);
      }).toList();

      return Future.wait(productDetailsFutures);
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondCont,
      padding: EdgeInsets.only(bottom: 80),
      child: FutureBuilder<List<Product>>(
        future: fetchFavoriteProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: cont,
              ),
            );
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No saved products found.');
          }

          List<Product> favoriteProducts = snapshot.data!;

          // return MasonryGridView.count(
          //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          //   crossAxisCount: 2,
          //   itemCount: products.length,
          //   itemBuilder: (context, index) {
          //     Product product = favoriteProducts[index];
          //     return ProductItem(product);
          //   },
          //   mainAxisSpacing: 4.0,
          //   crossAxisSpacing: 4.0,
          // );
          return GridView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 2 / 3,
            ),
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              Product product = favoriteProducts[index];

              return ProductItem(product);
            },
          );
        },
      ),
    );
  }
}
