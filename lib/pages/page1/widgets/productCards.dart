import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.width,
      required this.height,
      required this.top,
      required this.onTap,
      required this.pName,
      required this.discription,
      required this.price,
      this.quantity = '',
      required this.onTapDec,
      required this.negativeButton});
  final double width;
  final double height;
  final double top;
  final String pName;
  final String discription;
  final String price;
  final Function onTap;
  final Function onTapDec;
  final String quantity;
  final bool negativeButton;
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
              discription,
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
          Visibility(
            visible: negativeButton,
            child: Container(
              margin: EdgeInsets.only(
                top: height * 0.8,
                left: width * 0.4,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: TextButton(
                onPressed: () {
                  onTapDec();
                },
                style: ButtonStyle(
                  overlayColor:
                      MaterialStatePropertyAll<Color>(Colors.grey.shade100),
                ),
                child: const Text(
                  '-',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: height * 0.85,
              left: width * 0.62,
            ),
            child: Text(
              quantity,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: height * 0.8,
              left: width * 0.7,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white54),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              onPressed: () {
                onTap();
              },
              style: ButtonStyle(
                overlayColor:
                    MaterialStatePropertyAll<Color>(Colors.grey.shade100),
              ),
              child: const Text(
                'Add to cart',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
