import 'package:b_sell/appcolors.dart';
import 'package:b_sell/models/content_filter.dart';
import 'package:b_sell/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentsBottomModal extends StatefulWidget {
  final Product product;
  const CommentsBottomModal({super.key, required this.product});

  @override
  State<CommentsBottomModal> createState() => _CommentsBottomModalState();
}

class _CommentsBottomModalState extends State<CommentsBottomModal> {
  final _commentFocusNode = FocusNode();
  bool keypad = false;
  int commentLimit = 5;
  int totalComments = 0;
  TextEditingController commentController = TextEditingController();
  final InappropriateContentFilter _contentFilter = InappropriateContentFilter(
      ['business', 'shop', 'store', 'jewellery', 'gold', 'jewellers', 'jewelers'], // Define banned words
      [RegExp(r'\b\d{10}\b')] // Define banned patterns (Indian phone numbers)
      );

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} day${duration.inDays > 1 ? 's' : ''}';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hour${duration.inHours > 1 ? 's' : ''}';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minute${duration.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'a moment';
    }
  }

  void addComment() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // String username = user.displayName!;
      String commentText = commentController.text.trim();
      String filteredComment = _contentFilter.filterComment(commentText);

      // commentText != filteredComment ?
      // Fluttertoast.showToast(msg: "Invalid Comment") :

      if (commentText != filteredComment) {
        Fluttertoast.showToast(msg: "Invalid Comment");
      } else {
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
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        _commentFocusNode.unfocus();
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.25,
        maxChildSize: 0.95,
        expand: false,
        snap: true,
        snapSizes: const [0.25, 0.5, 0.75, 0.95],
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              // color: Colors.white,
            ),
            child: Column(
              children: [
                const Text(
                  'Golden Words',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10),
                _commentFocusNode.hasFocus
                    ? Container()
                    : Expanded(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('products')
                              .doc(widget.product.id)
                              .collection('comments')
                              .orderBy('timestamp', descending: true)
                              .limit(commentLimit)
                              .snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return const Text('No comments yet.');
                            }

                            return ListView(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: snapshot.data!.docs.map((commentDoc) {
                                Map<String, dynamic> commentData = commentDoc.data() as Map<String, dynamic>;
                                String uid = commentData['uid'];
                                var commentTimestamp = (commentData['timestamp'] as Timestamp).toDate();

                                return FutureBuilder(
                                  future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
                                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                                      return Container();
                                    }

                                    if (userSnapshot.hasError || !userSnapshot.hasData || !userSnapshot.data!.exists) {
                                      return const Text('User information not available');
                                    }

                                    Map<String, dynamic> userData = userSnapshot.data!.data()! as Map<String, dynamic>;
                                    String last4Digits = userData['phoneNumber'].substring(9);
                                    String maskedSubtitle = '******$last4Digits';
                                    var createdAt = commentTimestamp;
                                    var currentTime = DateTime.now();
                                    var difference = currentTime.difference(createdAt);

                                    return Card(
                                      elevation: 4.0,
                                      child: ListTile(
                                        autofocus: true,
                                        subtitle: Text(
                                          commentData['text'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        title: Text(
                                          '$maskedSubtitle - ${_formatDuration(difference)}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                Divider(
                  color: black,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: _commentFocusNode,
                          onTapOutside: (_) {
                            setState(() {
                              keypad = false;
                            });
                          },
                          onTap: () {
                            _commentFocusNode.requestFocus();
                            // setState(() {
                            //   keypad = true;
                            // });
                          },
                          controller: commentController,
                          decoration: const InputDecoration(
                            hintText: 'Add a comment...',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          Navigator.pop(context);
                          Future.delayed(const Duration(seconds: 2), () {
                            addComment();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                if (commentLimit < totalComments)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        commentLimit += 5;
                      });
                    },
                    child: const Text('Load More Comments'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
