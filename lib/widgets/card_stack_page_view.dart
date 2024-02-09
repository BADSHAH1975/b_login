import 'package:flutter/material.dart';

class CardStackPageView extends StatefulWidget {
  final List<Widget> cards; // Replace with your card widgets
  final double cardDistance; // Adjust distance between cards
  final double perspective; // Control 3D effect intensity

  const CardStackPageView({
    super.key,
    required this.cards,
    this.cardDistance = 16.0,
    this.perspective = 0.002,
  });

  @override
  State<CardStackPageView> createState() => _CardStackPageViewState();
}

class _CardStackPageViewState extends State<CardStackPageView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.cards.length,
      controller: PageController(initialPage: _currentIndex),
      onPageChanged: (index) => setState(() => _currentIndex = index),
      itemBuilder: (context, index) {
        final double scale = 1 - (index * widget.cardDistance) / MediaQuery.of(context).size.width;
        final double translateX = index * widget.cardDistance;
        final double translateZ = index * widget.perspective;

        return Transform(
          transform: Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, translateZ,
            0, translateX, 0, 1,
          ),
          child: Opacity(
            opacity: scale,
            child: widget.cards[index],
          ),
        );
      },
    );
  }
}
