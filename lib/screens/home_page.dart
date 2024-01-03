import 'package:b_sell/screens/product/product_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool search = false;

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            child: PageView.builder(
                itemCount: 3,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    'images/placeholder.png',
                    color: Colors.amber,
                  );
                }),
          ),
          _buildPageIndicator(),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 3,
              childAspectRatio: 5 / 2,
              children: [
                _productTypes('images/placeholder.png', 'Rings'),
                _productTypes('images/placeholder.png', 'Rings'),
                _productTypes('images/placeholder.png', 'Rings'),
                _productTypes('images/placeholder.png', 'Rings'),
                _productTypes('images/placeholder.png', 'Rings'),
                _productTypes('images/placeholder.png', 'Rings'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductPage()));
                    },
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          return Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 3,
              backgroundColor: _currentPage == index ? Colors.amber : Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Widget _productTypes(String image, String text) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 200,
        height: 100,
        // padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 100,
              height: 100,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
