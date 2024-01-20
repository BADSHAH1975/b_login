import 'package:b_sell/appcolors.dart';
import 'package:b_sell/models/product.dart';
import 'package:b_sell/screens/product/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<String> products = List.generate(20, (index) => 'Product $index'); // Example product list
  bool isLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Reach the end of the list - load more products
      // _loadMoreProducts();
    }
  }

  Future<void> _loadMoreProducts() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));

    List<String> moreProducts = List.generate(20, (index) => 'New Product ${products.length + index}');
    setState(() {
      products.addAll(moreProducts);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondCont,
      appBar: AppBar(
        // title: Text('Product Page'),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: cont,
              ));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final products = snapshot.data!.docs
                  .map((doc) => Product(
                        id: doc.id,
                        name: doc['name'],
                        price: doc['price'],
                        description: doc['description'],
                        type: doc['type'],
                        imageUrl: doc['image_url'],
                        likes: doc['likes'],
                      ))
                  .toList();

              return MasonryGridView.count(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                crossAxisCount: 2,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItem(product);
                },
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              );
              // GridView.builder(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   controller: _scrollController,
              //   itemCount: isLoading ? products.length + 1 : products.length,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 8.0,
              //     crossAxisSpacing: 8.0,
              //     childAspectRatio: 2 / 3,
              //   ),
              //   itemBuilder: (BuildContext context, int index) {
              //     if (index == products.length) {
              //       return Center(
              //         child: CircularProgressIndicator(
              //           color: cont,
              //         ),
              //       );
              //     } else {
              //       final product = products[index];
              //       return ProductItem(product);
              //     }
              //   },
              // );
            }
          }),
    );
  }
}
