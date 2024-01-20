import 'dart:io';

import 'package:b_sell/appcolors.dart';
import 'package:b_sell/main.dart';
import 'package:b_sell/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _fav = false;
  bool _commentsOpen = false;
  bool _save = false;

  @override
  void initState() {
    super.initState();
    // isProductInSaved(userDocRef, widget.product.id);
  }

  void toggleSavedStatus(String productId) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      bool isFavorite = await isProductInSaved(userDocRef, productId);
      if (isFavorite) {
        userDocRef.collection('saved').doc(productId).delete();
      } else {
        userDocRef.collection('saved').doc(productId).set({
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  Future<bool> isProductInSaved(DocumentReference userDocRef, String productId) async {
    DocumentSnapshot snapshot = await userDocRef.collection('saved').doc(productId).get();
    return snapshot.exists;
  }

  void incrementLikes(Product product) {
    FirebaseFirestore.instance.collection('products').doc(product.id).update({
      'likes': FieldValue.increment(1),
    });
  }

  void decrementLikes(Product product) {
    FirebaseFirestore.instance.collection('products').doc(product.id).update({
      'likes': FieldValue.increment(-1),
    });
  }

  void shareProductOnWhatsApp(Product product) async {
    final String productName = Uri.encodeComponent(product.name);
    final String productPrice = Uri.encodeComponent(product.price.toString());

    final String message = 'Check out this product: $productName, Price: $productPrice';

    final String whatsappUrl = 'https://wa.me/?text=$message';

    if (!await launchUrl(Uri.parse(whatsappUrl))) {
      throw 'Could not launch $whatsappUrl';
    } else {
      await launchUrl(Uri.parse(whatsappUrl));
    }
  }

  // void shareToWhatsApp(String documentId) async {
  //   String imageUrl = await fetchImageUrl(documentId);
  //   if (imageUrl == null) {
  //     return;
  //   }

  //   // Combine text and price
  //   String message = "${widget.product.name} - ${widget.product.price}";

  //   File imageFile = await File(imageUrl).downloadFile();
  //   ShareOptions options = ShareOptions(
  //     text: message,
  //     subject: "Amazing Deal!",
  //     shareMedia: imageFile,
  //   );

  //   // Share using Share.share
  //   await Share.share(options);

  //   String appLink = "https://play.google.com/store/apps/details?id=your_app_id";

  //   String whatsappUrl = "https://wa.me/?text=$message&url=$appLink";
  //    if (!await launchUrl(Uri.parse(whatsappUrl))) {
  //     throw 'Could not launch $whatsappUrl';
  //   } else {
  //     await launchUrl(Uri.parse(whatsappUrl));
  //   }

  //   // Delete downloaded image after sharing (optional)
  //   imageFile.delete();
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: secondCont,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 100,
            ),
            // Image.asset(
            //   'images/diamondring.png',
            //   height: MediaQuery.of(context).size.height * 0.35,
            //   width: double.infinity,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(
                widget.product.imageUrl,
                height: MediaQuery.of(context).size.height * 0.55,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.product.name.toUpperCase(),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '\u20B9${widget.product.price.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  size: 24.0,
                  color: Colors.red,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('products').doc(widget.product.id).snapshots(),
                  builder: (context, snapshot) {
                    int currentLikes = snapshot.data?['likes'] ?? widget.product.likes;

                    return Text(
                      '${currentLikes} people like this',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    );
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  widget.product.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _fav = !_fav;
                      });
                      if (_fav) {
                        FirebaseFirestore.instance.collection('products').doc(widget.product.id).update({
                          'likes': FieldValue.increment(1),
                        });
                      } else {
                        FirebaseFirestore.instance.collection('products').doc(widget.product.id).update({
                          'likes': FieldValue.increment(-1),
                        });
                      }
                    },
                    iconSize: 30,
                    icon: _fav
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                          ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _commentsOpen = !_commentsOpen;
                      });
                    },
                    iconSize: 30,
                    icon: Icon(
                      Icons.comment_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      shareProductOnWhatsApp(widget.product);
                    },
                    iconSize: 30,
                    icon: Icon(
                      Icons.share_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _save = !_save;
                      });
                      toggleSavedStatus(widget.product.id);
                    },
                    iconSize: 30,
                    icon: _save
                        ? Icon(Icons.bookmark)
                        : Icon(
                            Icons.bookmark_border_outlined,
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            _commentsOpen ? _commentsList() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _commentsList() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Comments',
              style: TextStyle(),
              // textAlign: TextAlign.start,
            ),
          ),
        ),
        Container(
          child: Text('comments'),
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
        ),
        Divider(
          color: cont,
          indent: 30,
          endIndent: 30,
        ),
      ],
    );
  }
}
