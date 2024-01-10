import 'package:b_sell/appcolors.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: double.maxFinite,
        width: double.infinity,
        color: secondCont,
        child: Text('Offers'),
      ),
    );
  }
}
