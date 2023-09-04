import 'package:dealberg/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottomSheetBloc/bottomSheetBloc.dart';
import '../../bloc/cartBloc/cartBloc.dart';
import '../page1/widgets/productCards.dart';

class CartPgae extends StatefulWidget {
  const CartPgae({super.key});

  @override
  State<CartPgae> createState() => _CartPgaeState();
}

class _CartPgaeState extends State<CartPgae> {
  final CartManagement _cartManagement = CartManagement();
  final BottomSheetBloc _bottomSheetBloc = BottomSheetBloc();
  @override
  void initState() {
    // TODO: implement initState
    _cartManagement.add(GetProducts());
    _bottomSheetBloc.add(AddAmountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
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
                              _cartManagement.add(QuantityIncrement(
                                  id: state.allProducts[index].id!));
                              _bottomSheetBloc.add(AddAmountEvent());
                            },
                            pName: state.allProducts[index].productName!,
                            discription: state.allProducts[index].description!,
                            price: state.allProducts[index].price!,
                            quantity: (state.allProducts[index].quantity! == 0)
                                ? ''
                                : state.allProducts[index].quantity!.toString(),
                            onTapDec: () {
                              _cartManagement.add(RmvFromCart(
                                  id: state.allProducts[index].id!));
                              _bottomSheetBloc.add(AddAmountEvent());
                            },
                            negativeButton:
                                (state.allProducts[index].quantity! == 0)
                                    ? false
                                    : true,
                            imageLink: ((state.allProducts[index].image!) == '')
                                ? image[index]
                                : (state.allProducts[index].image!),
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                        ],
                      );
                    }),
              );
            } else if (state is LoadingCartState) {
              return const Center(
                child: Text(
                  'No Products',
                  style: TextStyle(fontSize: 25),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      bottomSheet: BlocProvider(
        create: (_) => _bottomSheetBloc,
        child: BlocBuilder<BottomSheetBloc, BottomSheetState>(
          builder: (context, state) {
            if (state is ShowBottomSheetState) {
              return Container(
                height: height * 0.1,
                decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Row(
                  children: [
                    Container(
                      width: width * 0.3,
                      margin: EdgeInsets.only(left: width * 0.05),
                      child: Text(
                        '${state.totalAmt} rs',
                        style: TextStyle(
                            color: Colors.black, fontSize: width * 0.05),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.35),
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          border: Border.all(color: Colors.black87),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: MaterialStatePropertyAll<Color>(
                              Colors.grey.shade100),
                        ),
                        child: Text(
                          'Place Order',
                          style: TextStyle(
                              color: Colors.black, fontSize: width * 0.045),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (State is HideBottomSheetState) {
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
