import 'package:b_sell/models/product.dart';
import 'package:b_sell/screens/product/product_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  ProductItem(this.product);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFEFEEEE),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Image.network(
            widget.product.imageUrl,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        );
      },
      openBuilder: (BuildContext _, VoidCallback __) {
        return ProductPage(
          product: widget.product,
        );
      },
    );
  }
}
