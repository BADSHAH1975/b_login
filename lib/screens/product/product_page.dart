import 'dart:io';

import 'package:b_sell/appcolors.dart';
import 'package:b_sell/main.dart';
import 'package:b_sell/models/product.dart';
import 'package:b_sell/widgets/comments_bottom_modal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _like = false;
  // bool _commentsOpen = false;
  // bool _loadMoreComments = false;
  int totalComments = 0;
  bool _save = false;
  int commentLimit = 5;
  TextEditingController commentController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    checkProductSavedStatus();
    checkProductLikedStatus();
  }

  // String _formatDuration(Duration duration) {
  //   if (duration.inDays > 0) {
  //     return '${duration.inDays} day${duration.inDays > 1 ? 's' : ''}';
  //   } else if (duration.inHours > 0) {
  //     return '${duration.inHours} hour${duration.inHours > 1 ? 's' : ''}';
  //   } else if (duration.inMinutes > 0) {
  //     return '${duration.inMinutes} minute${duration.inMinutes > 1 ? 's' : ''}';
  //   } else {
  //     return 'a moment';
  //   }
  // }

  void toggleSavedStatus(Product product) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      bool isSaved = await isProductInSaved(userDocRef, product.id);
      if (isSaved) {
        userDocRef.collection('saved').doc(product.id).delete();
        FirebaseFirestore.instance.collection('products').doc(product.id).collection('saves').doc(user.uid).delete();
        updateSaves(product);
      } else {
        userDocRef.collection('saved').doc(product.id).set({
          'timestamp': FieldValue.serverTimestamp(),
        });

        updateSaves(product);

        FirebaseFirestore.instance.collection('products').doc(product.id).collection('saves').doc(user.uid).set({
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  void updateSaves(Product product) async {
    final savesQuery =
        await FirebaseFirestore.instance.collection('products').doc(product.id).collection('saves').get();
    final savesCount = savesQuery.size;

    FirebaseFirestore.instance.collection('products').doc(product.id).update({
      'savesCount': savesCount,
    });
  }

  void checkProductSavedStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      bool isFavorite = await isProductInSaved(userDocRef, widget.product.id);
      setState(() {
        _save = isFavorite;
      });
    }
  }

  Future<bool> isProductInSaved(DocumentReference userDocRef, String productId) async {
    DocumentSnapshot snapshot = await userDocRef.collection('saved').doc(productId).get();
    return snapshot.exists;
  }

  void checkProductLikedStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      bool isLiked = await isProductLiked(userDocRef, widget.product.id);
      setState(() {
        _like = isLiked;
      });
    }
  }

  Future<bool> isProductLiked(DocumentReference userDocRef, String productId) async {
    DocumentSnapshot snapshot = await userDocRef.collection('liked').doc(productId).get();
    return snapshot.exists;
  }

  void toggleLikedStatus(Product product) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      bool isLiked = await isProductLiked(userDocRef, product.id);
      if (isLiked) {
        userDocRef.collection('liked').doc(product.id).delete();
        updateLikes(product);

        FirebaseFirestore.instance.collection('products').doc(product.id).collection('likes').doc(user.uid).delete();
      } else {
        userDocRef.collection('liked').doc(product.id).set({
          'timestamp': FieldValue.serverTimestamp(),
        });
        updateLikes(product);

        FirebaseFirestore.instance.collection('products').doc(product.id).collection('likes').doc(user.uid).set({
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  void updateLikes(Product product) async {
    final likesQuery =
        await FirebaseFirestore.instance.collection('products').doc(product.id).collection('likes').get();
    final likesCount = likesQuery.size;

    FirebaseFirestore.instance.collection('products').doc(product.id).update({
      'likesCount': likesCount,
    });
  }

  // void incrementLikes(Product product) {
  //   FirebaseFirestore.instance.collection('products').doc(product.id).update({
  //     // 'likesCount': FieldValue.increment(1),
  //     'likesCount': FirebaseFirestore.instance.collection('products').doc(product.id).collection('likes').count(),
  //   });
  // }

  // void decrementLikes(Product product) {
  //   FirebaseFirestore.instance.collection('products').doc(product.id).update({
  //     'likes': FieldValue.increment(-1),
  //   });
  // }

  void addComment() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // String username = user.displayName!;
      String commentText = commentController.text.trim();

      if (commentText.isNotEmpty) {
        await FirebaseFirestore.instance.collection('products').doc(widget.product.id).collection('comments').add({
          'text': commentText,
          // 'username': username,
          'timestamp': FieldValue.serverTimestamp(),
          'uid': user.uid,
        });

        commentController.clear();
      }
    }
  }

  Future<void> _takeScreenshotAndShare(String productId) async {
    try {
      final image = await screenshotController.capture();
      if (image != null) {
        // Add null check here
        final directory = await getTemporaryDirectory();
        final path = '${directory.path}/screenshot.png';
        // await image.writeAsBytes(File(path).writeAsBytesSync());
        final file = File(path);
        await file.writeAsBytes(image);
        // await image.
        final xFile = XFile(path);
        Share.shareXFiles([xFile], text: 'Check out this product from Taqwa Jewellers!');
        // Share.shareXFiles(path, )

        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({'sharesCount': FieldValue.increment(1)});
      } else {
        logger.e('Failed to capture screenshot');
      }
    } catch (error) {
      logger.e('Error taking screenshot: $error');
    }
  }

  String formatIndianCurrency(double? price) {
    NumberFormat indianCurrencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    return indianCurrencyFormat.format(price);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return Screenshot(
          controller: screenshotController,
          child: Scaffold(
            backgroundColor: white,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0.0,
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // const SizedBox(
                  //   height: 100,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: InteractiveViewer(
                  //     // constrained: false,
                  //     // panAxis: PanAxis.aligned,
                  //     child: CachedNetworkImage(
                  //       imageUrl: widget.product.imageUrl,
                  //       height: MediaQuery.of(context).size.height * 0.55,
                  //     ),
                  //   ),
                  // ),
                  InteractiveViewer(
                    minScale: 0.1,
                    maxScale: 2.0,
                    child: CachedNetworkImage(
                      imageUrl: widget.product.imageUrl,
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            widget.product.name.toUpperCase(),
                            maxLines: 1,
                            style: GoogleFonts.cinzelDecorative(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: black,
                            ),
                          ),
                          // RichText(
                          //     text: TextSpan(
                          //   style: GoogleFonts.cinzelDecorative(
                          //     fontSize: 26,
                          //     fontWeight: FontWeight.w800,
                          //     color: black,
                          //   ),
                          //   children: [

                          //     TextSpan(
                          //       text: widget.product.name.toUpperCase(),
                          //     ),
                          //   ],
                          // )
                          //     // style: GoogleFonts.cormorantGaramond(
                          //     //   fontSize: 30,
                          //     //   fontWeight: FontWeight.w800,
                          //     //   color: black,
                          //     // ),
                          //     ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('static').doc('rate').snapshots(),
                            builder: (context, snapshot) {
                              double? rate = snapshot.data?['rate'];
                              if (rate != null) {
                                // logger.i('Rate: $rate');
                                var exactPrice =
                                    (rate * widget.product.grams) + widget.product.gst + widget.product.otherCharges;
                                final stringPrice = formatIndianCurrency(exactPrice);

                                return Text(
                                  stringPrice.substring(0, stringPrice.length - 3),
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: black,
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Icon(
                  //       Icons.favorite,
                  //       size: 24.0,
                  //       color: Colors.red,
                  //     ),
                  //     StreamBuilder(
                  //       stream: FirebaseFirestore.instance.collection('products').doc(widget.product.id).snapshots(),
                  //       builder: (context, snapshot) {
                  //         int currentLikes = snapshot.data?['likesCount'] ?? widget.product.likesCount;

                  //         return Text(
                  //           ' $currentLikes people like this',
                  //           style: const TextStyle(
                  //             fontSize: 16,
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      widget.product.description,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _like = !_like;
                                });

                                toggleLikedStatus(widget.product);
                              },
                              iconSize: 30,
                              icon: _like
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                    ),
                            ),
                            StreamBuilder(
                              stream:
                                  FirebaseFirestore.instance.collection('products').doc(widget.product.id).snapshots(),
                              builder: (context, snapshot) {
                                int currentLikes = snapshot.data?['likesCount'] ?? 0;
                                return Text(
                                  currentLikes.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                // setState(() {
                                //   _commentsOpen = !_commentsOpen;
                                // });

                                // _showBottomCommentsModal(context);
                                showModalBottomSheet(
                                  context: context,
                                  showDragHandle: true,
                                  // backgroundColor: Colors.white,
                                  isScrollControlled: true,

                                  builder: (context) {
                                    return CommentsBottomModal(product: widget.product);
                                  },
                                );
                              },
                              iconSize: 30,
                              icon: const Icon(
                                Icons.comment_outlined,
                              ),
                            ),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('products')
                                  .doc(widget.product.id)
                                  .collection('comments')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Container();
                                }
                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return const Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  );
                                }
                                int length = snapshot.data!.docs.length;

                                return Text(
                                  length.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _save = !_save;
                                });
                                toggleSavedStatus(widget.product);
                              },
                              iconSize: 30,
                              icon: _save
                                  ? const Icon(Icons.bookmark)
                                  : const Icon(
                                      Icons.bookmark_border_outlined,
                                    ),
                            ),
                            StreamBuilder(
                              stream:
                                  FirebaseFirestore.instance.collection('products').doc(widget.product.id).snapshots(),
                              builder: (context, snapshot) {
                                int currentLikes = snapshot.data?['savesCount'] ?? 0;
                                return Text(
                                  currentLikes.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onPressed: () {
                                // shareProductOnWhatsApp(widget.product);
                                _takeScreenshotAndShare(widget.product.id);
                              },
                              iconSize: 30,
                              icon: const Icon(
                                Icons.share_outlined,
                              ),
                            ),
                            StreamBuilder(
                              stream:
                                  FirebaseFirestore.instance.collection('products').doc(widget.product.id).snapshots(),
                              builder: (context, snapshot) {
                                int currentShares = snapshot.data?['sharesCount'] ?? 0;
                                return Text(
                                  currentShares.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // _commentsOpen ? _commentsList() : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _commentsList() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 10),
  //     child: Column(
  //       children: [
  //         const Align(
  //           alignment: Alignment.centerLeft,
  //           child: Text('Comments'),
  //         ),
  //         StreamBuilder(
  //           stream: FirebaseFirestore.instance
  //               .collection('products')
  //               .doc(widget.product.id)
  //               .collection('comments')
  //               .orderBy('timestamp', descending: true)
  //               .limit(commentLimit)
  //               .snapshots(),
  //           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return const CircularProgressIndicator();
  //             }

  //             if (snapshot.hasError) {
  //               return Text('Error: ${snapshot.error}');
  //             }

  //             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  //               return const Text('No comments yet.');
  //             }

  //             totalComments = snapshot.data!.docs.length;
  //             User? user = FirebaseAuth.instance.currentUser;
  //             String last4Digits = user!.phoneNumber!.substring(9);
  //             String maskedSubtitle = '******$last4Digits';

  //             return Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: snapshot.data!.docs.map((commentDoc) {
  //                 Map<String, dynamic> commentData = commentDoc.data() as Map<String, dynamic>;
  //                 return ListTile(
  //                   autofocus: true,
  //                   subtitle: Text(
  //                     commentData['text'],
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                   title: Text(
  //                     '${maskedSubtitle}',
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                     ),
  //                   ),
  //                 );
  //               }).toList(),
  //             );
  //           },
  //         ),
  //         if (commentLimit < totalComments)
  //           GestureDetector(
  //             onTap: () {
  //               setState(() {
  //                 commentLimit += 5;
  //               });
  //             },
  //             child: const Text('Load More Comments'),
  //           ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: TextField(
  //                   controller: commentController,
  //                   decoration: const InputDecoration(
  //                     hintText: 'Add a comment...',
  //                   ),
  //                 ),
  //               ),
  //               IconButton(
  //                 icon: const Icon(Icons.send),
  //                 onPressed: () {
  //                   addComment();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _showBottomCommentsModal(BuildContext context) {
  //   showModalBottomSheet(
  //     showDragHandle: true,
  //     context: context,
  //     // backgroundColor: Colors.white,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: 0.85,
  //         minChildSize: 0.25,
  //         maxChildSize: 0.95,
  //         expand: false,
  //         snap: true,
  //         snapSizes: const [0.25, 0.5, 0.75, 0.95],
  //         builder: (BuildContext context, ScrollController scrollController) {
  //           return Container(
  //             width: double.infinity,
  //             padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
  //             decoration: const BoxDecoration(
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(16.0),
  //                 topRight: Radius.circular(16.0),
  //               ),
  //               // color: Colors.white,
  //             ),
  //             child: Column(
  //               children: [
  //                 const Text(
  //                   'Golden Words',
  //                   style: TextStyle(fontSize: 18.0),
  //                 ),
  //                 const SizedBox(height: 10),
  //                 Expanded(
  //                   child: StreamBuilder(
  //                     stream: FirebaseFirestore.instance
  //                         .collection('products')
  //                         .doc(widget.product.id)
  //                         .collection('comments')
  //                         .orderBy('timestamp', descending: true)
  //                         .limit(commentLimit)
  //                         .snapshots(),
  //                     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //                       if (snapshot.connectionState == ConnectionState.waiting) {
  //                         return const Center(
  //                           child: CircularProgressIndicator(
  //                             color: Colors.black,
  //                           ),
  //                         );
  //                       }

  //                       if (snapshot.hasError) {
  //                         return Text('Error: ${snapshot.error}');
  //                       }

  //                       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  //                         return const Text('No comments yet.');
  //                       }

  //                       return ListView(
  //                         // crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: snapshot.data!.docs.map((commentDoc) {
  //                           Map<String, dynamic> commentData = commentDoc.data() as Map<String, dynamic>;
  //                           String uid = commentData['uid'];
  //                           var commentTimestamp = (commentData['timestamp'] as Timestamp).toDate();

  //                           return FutureBuilder(
  //                             future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
  //                             builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
  //                               if (userSnapshot.connectionState == ConnectionState.waiting) {
  //                                 return Container();
  //                               }

  //                               if (userSnapshot.hasError || !userSnapshot.hasData || !userSnapshot.data!.exists) {
  //                                 return const Text('User information not available');
  //                               }

  //                               Map<String, dynamic> userData = userSnapshot.data!.data()! as Map<String, dynamic>;
  //                               String last4Digits = userData['phoneNumber'].substring(9);
  //                               String maskedSubtitle = '******$last4Digits';
  //                               var createdAt = commentTimestamp;
  //                               var currentTime = DateTime.now();
  //                               var difference = currentTime.difference(createdAt);

  //                               return Card(
  //                                 elevation: 4.0,
  //                                 child: ListTile(
  //                                   autofocus: true,
  //                                   subtitle: Text(
  //                                     commentData['text'],
  //                                     style: const TextStyle(
  //                                       fontSize: 18,
  //                                     ),
  //                                   ),
  //                                   title: Text(
  //                                     '$maskedSubtitle - ${_formatDuration(difference)}',
  //                                     style: const TextStyle(
  //                                       fontSize: 14,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               );
  //                             },
  //                           );
  //                         }).toList(),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 Divider(
  //                   color: black,
  //                   thickness: 1,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         child: TextField(
  //                           controller: commentController,
  //                           decoration: const InputDecoration(
  //                             hintText: 'Add a comment...',
  //                           ),
  //                         ),
  //                       ),
  //                       IconButton(
  //                         icon: const Icon(Icons.send),
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                           Future.delayed(Duration(seconds: 2), () {
  //                             addComment();
  //                           });
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 if (commentLimit < totalComments)
  //                   GestureDetector(
  //                     onTap: () {
  //                       setState(() {
  //                         commentLimit += 5;
  //                       });
  //                     },
  //                     child: const Text('Load More Comments'),
  //                   ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
