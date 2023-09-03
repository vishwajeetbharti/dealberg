import 'package:dealberg/bloc/homeBloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Utils/constants.dart';
import '../../bloc/cartBloc/cartBloc.dart';
import '../page1/widgets/productCards.dart';

class CartPgae extends StatefulWidget {
  const CartPgae({super.key});

  @override
  State<CartPgae> createState() => _CartPgaeState();
}

class _CartPgaeState extends State<CartPgae> {
  final CartManagement _cartManagement = CartManagement();
  final ProductsManagement _management = ProductsManagement();
  @override
  void initState() {
    // TODO: implement initState
    _cartManagement.add(GetProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          BlocProvider(
            create: (_) => _cartManagement,
            child: BlocBuilder<CartManagement, CartState>(
              builder: (context, state) {
                if (state is CartProducts) {
                  return SizedBox(
                    height: height * 0.9,
                    child: ListView.builder(
                        itemCount: state.allProducts.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SizedBox(
                                width: width * 0.05,
                              ),
                              ProductCard(
                                width: width * 0.9,
                                height: height * 0.3,
                                top: height * 0.01,
                                onTap: () {
                                  // _management.add(AddToCart(
                                  //     prod: listThings[index].protectedDetails!));
                                  //
                                  // setState(() {
                                  //   totalAmt += double.parse(listThings[index]
                                  //       .protectedDetails!
                                  //       .price!);
                                  //   cartQun[index] += 1;
                                  // });
                                },
                                pName: state.allProducts[index].productName!,
                                discription:
                                    state.allProducts[index].description!,
                                price: state.allProducts[index].price!,
                                quantity:
                                    (state.allProducts[index].quantity! == 0)
                                        ? ''
                                        : state.allProducts[index].quantity!
                                            .toString(),
                                onTapDec: () {
                                  // totalAmt -= double.parse(
                                  //     listThings[index].protectedDetails!.price!);
                                  _management.add(RmvToCart(
                                    id: state.allProducts[index].id!,
                                  ));
                                  //
                                  // setState(() {
                                  //   cartQun[index] -= 1;
                                  // });
                                  // if (totalAmt < 1) {
                                  //   Navigator.pop(context);
                                  // }
                                },
                                negativeButton:
                                    (state.allProducts[index].quantity! == 0)
                                        ? false
                                        : true,
                              ),
                              SizedBox(
                                width: width * 0.05,
                              ),
                            ],
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: Text('No Products'),
                  );
                }
              },
            ),
          )
        ],
      ),
      bottomSheet: Visibility(
        visible: (totalAmt > 0),
        child: Container(
          height: height * 0.1,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Row(
            children: [
              Container(
                width: width * 0.3,
                margin: EdgeInsets.only(left: width * 0.05),
                child: Text(
                  '${totalAmt.toString()} rs',
                  style: const TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: width * 0.35),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor:
                        MaterialStatePropertyAll<Color>(Colors.grey.shade100),
                  ),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
