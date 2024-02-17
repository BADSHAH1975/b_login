import 'package:animations/animations.dart';
import 'package:b_sell/models/product.dart';
import 'package:b_sell/screens/product/product_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductSearchItem extends StatefulWidget {
  final Product product;

  const ProductSearchItem({super.key, required this.product});

  @override
  State<ProductSearchItem> createState() => _ProductSearchItemState();
}

class _ProductSearchItemState extends State<ProductSearchItem> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return ListTile(
          leading: SizedBox(
            width: 60,
            child: CachedNetworkImage(
              imageUrl: widget.product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(widget.product.name),
        );
        // Container(
        //   decoration: BoxDecoration(
        //     color: Color(0xFFEFEEEE),
        //     borderRadius: BorderRadius.circular(2.0),
        //   ),
        //   child: CachedNetworkImage(
        //     imageUrl: widget.product.imageUrl,
        //     fit: BoxFit.cover,
        //     placeholder: (context, url) => Container(),
        //     errorWidget: (context, url, error) => Icon(Icons.error),
        //   ),
        // );
      },
      openBuilder: (BuildContext _, VoidCallback __) {
        return ProductPage(
          product: widget.product,
        );
      },
    );
  }
}
