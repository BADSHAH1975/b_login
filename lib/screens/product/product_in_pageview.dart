import 'package:animations/animations.dart';
import 'package:b_sell/models/product.dart';
import 'package:b_sell/screens/product/product_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductInPageView extends StatefulWidget {
  final Product product;
  const ProductInPageView({super.key, required this.product});

  @override
  State<ProductInPageView> createState() => _ProductInPageViewState();
}

class _ProductInPageViewState extends State<ProductInPageView> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      closedElevation: 0.0,
      closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return CachedNetworkImage(
          imageUrl: widget.product.imageUrl,
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
