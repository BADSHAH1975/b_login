import 'package:b_sell/models/product.dart';
import 'package:b_sell/screens/product/product_page.dart';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEFEEEE),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: CachedNetworkImage(
            imageUrl: widget.product.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
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
