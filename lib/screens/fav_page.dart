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
  bool isLoading = false;

  Future<Product> fetchProductDetails(String productId) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot productSnapshot = await FirebaseFirestore.instance.collection('products').doc(productId).get();

    if (!productSnapshot.exists) {
      await firestore.collection('users').doc(user!.uid).collection('saved').doc(productId).delete();
    }

    return Product(
      id: productId,
      name: productSnapshot['name'] ?? '',
      grams: productSnapshot['grams'].toDouble() ?? 0.0,
      description: productSnapshot['description'] ?? '',
      type: productSnapshot['type'] ?? '',
      imageUrl: productSnapshot['image_url'] ?? '',
      gst: productSnapshot['gst'].toDouble() ?? 0,
      otherCharges: productSnapshot['other_charges'].toDouble() ?? 0,
      likesCount: productSnapshot['likesCount'] ?? '',
      savesCount: productSnapshot['savesCount'] ?? '',
      sharesCount: productSnapshot['sharesCount'] ?? '',
      category: productSnapshot['category'] ?? '',
    );
  }

  Future<List<Product>> fetchFavoriteProductDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      CollectionReference savedRef = userDocRef.collection('saved');
      QuerySnapshot snapshot = await savedRef.get();

      List<String> favoriteProductIds = snapshot.docs.map((savedID) => savedID.id).toList();

      List<Future<Product?>> productDetailsFutures = favoriteProductIds.map((productId) {
        return fetchProductDetails(productId);
      }).toList();

      await Future.delayed(const Duration(milliseconds: 3000));

      // List<Product> validProductsDetails = [];
      List<Product?> productDetailsList = await Future.wait(productDetailsFutures);

      // for (int i = 0; i < favoriteProductIds.length; i++) {
      //   if (productDetailsList[i] != null) {
      //     validProductsDetails.add(productDetailsList[i]!);
      //   } else {
      //     logger.e('Product details not found ID: ${favoriteProductIds[i]}');
      //   }
      // }

      List<Product> validProductDetails =
          productDetailsList.where((product) => product != null).cast<Product>().toList();

      return validProductDetails;
    }

    return [];
  }

  Stream<List<Product>> fetchFavoriteProductDetailsStream() async* {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      CollectionReference savedRef = userDocRef.collection('saved');

      await for (QuerySnapshot snapshot in savedRef.snapshots()) {
        List<String> favoriteProductIds = snapshot.docs.map((savedID) => savedID.id).toList();

        List<Future<Product?>> productDetailsFutures = favoriteProductIds.map((productId) {
          return fetchProductDetails(productId);
        }).toList();
        await Future.delayed(const Duration(milliseconds: 1000));

        // Wait for all futures to complete
        List<Product?> productDetailsList = await Future.wait(productDetailsFutures);

        // Filter out null product details
        List<Product> validProductDetails =
            productDetailsList.where((product) => product != null).cast<Product>().toList();

        yield validProductDetails;
      }
    }
    yield []; // Return an empty list if user is null or other conditions are not met
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: white,
      ),
      padding: const EdgeInsets.only(bottom: 80),
      child: StreamBuilder<List<Product>>(
        stream: fetchFavoriteProductDetailsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: cont,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No saved products found.'));
          }

          List<Product> favoriteProducts = snapshot.data!;

          return MasonryGridView.count(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            crossAxisCount: 2,
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              return ProductItem(product);
            },
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );
        },
      ),
    );

    //       FutureBuilder<List<Product>>(
    //     future: fetchFavoriteProductDetails(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(
    //             color: cont,
    //           ),
    //         );
    //       }

    //       if (snapshot.hasError) {
    //         return Text('Error: ${snapshot.error}');
    //       }

    //       if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //         return const Text('No saved products found.');
    //       }

    //       List<Product> favoriteProducts = snapshot.data!;

    //       return MasonryGridView.count(
    //         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //         crossAxisCount: 2,
    //         itemCount: favoriteProducts.length,
    //         itemBuilder: (context, index) {
    //           final product = favoriteProducts[index];
    //           return ProductItem(product);
    //         },
    //         mainAxisSpacing: 4.0,
    //         crossAxisSpacing: 4.0,
    //       );
    //     },
    //   ),
    // );
  }
}
