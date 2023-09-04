import 'package:flutter/material.dart';

import '../../../Utils/constants.dart';

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
      required this.negativeButton,
      required this.imageLink});
  final double width;
  final double height;
  final double top;
  final String pName;
  final String discription;
  final String price;
  final Function onTap;
  final Function onTapDec;
  final String quantity;
  final String imageLink;
  final bool negativeButton;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height * 0.65,
          width: width,
          margin: EdgeInsets.only(top: top),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(imageLink),
            ),
          ),
        ),
        Container(
          width: width,
          height: 1,
          color: Colors.black,
        ),
        Container(
          width: width,
          height: height * 0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.04,
                  left: width * 0.03,
                ),
                child: Text(
                  pName,
                  style:
                      TextStyle(fontSize: width * 0.05, color: Colors.black87),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.15,
                  left: width * 0.03,
                ),
                child: Text(
                  discription,
                  style:
                      TextStyle(fontSize: width * 0.03, color: Colors.black87),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.3,
                  left: width * 0.03,
                ),
                child: Text(
                  price,
                  style:
                      TextStyle(fontSize: width * 0.05, color: Colors.black87),
                ),
              ),
              Visibility(
                visible: negativeButton,
                child: Container(
                  margin: EdgeInsets.only(
                    top: height * 0.3,
                    left: width * 0.4,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: TextButton(
                    onPressed: () {
                      onTapDec();
                    },
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll<Color>(Colors.grey.shade100),
                    ),
                    child: Text(
                      '-',
                      style: TextStyle(
                          color: Colors.black87, fontSize: width * 0.05),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.35,
                  left: width * 0.62,
                ),
                child: Text(
                  quantity,
                  style:
                      TextStyle(fontSize: width * 0.05, color: Colors.black87),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.3,
                  left: width * 0.7,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                  onPressed: () {
                    onTap();
                  },
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStatePropertyAll<Color>(Colors.grey.shade100),
                  ),
                  child: Text(
                    Strings.addToCart,
                    style: TextStyle(
                        color: Colors.black87, fontSize: width * 0.05),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
