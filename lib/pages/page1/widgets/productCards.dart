import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.width,
      required this.height,
      required this.top,
      required this.pName,
      required this.price,
      required this.description});
  final double width;
  final double height;
  final double top;
  final String pName, price, description;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: top),
      decoration: const BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: height * 0.6,
              left: width * 0.03,
            ),
            child: Text(
              pName,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: height * 0.68,
              left: width * 0.03,
            ),
            child: Text(
              description,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: height * 0.85,
              left: width * 0.03,
            ),
            child: Text(
              price,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                top: height * 0.8,
                left: width * 0.7,
              ),
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor:
                      MaterialStatePropertyAll<Color>(Colors.grey.shade100),
                ),
                child: const Text(
                  'Add to cart',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )),
        ],
      ),
    );
  }
}
