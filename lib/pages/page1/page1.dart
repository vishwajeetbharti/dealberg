import 'package:dealberg/pages/page1/widgets/productCards.dart';
import 'package:dealberg/pages/page1/widgets/search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottomSheetBloc/bottomSheetBloc.dart';
import '../../bloc/homeBloc/bloc.dart';
import '../page2/page2.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _controllerSearch = TextEditingController();
  final ProductsManagement _management = ProductsManagement();
  final BottomSheetBloc _bottomSheet = BottomSheetBloc();

  @override
  void initState() {
    super.initState();
    _management.add(InitialEvent());
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: !kIsWeb
          ? AppBar(
              title: const Text(
                'DEALBERG',
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              actions: [
                // BlocProvider(
                //   create: (_) => _bottomSheet,
                //   child: BlocBuilder<BottomSheetBloc, BottomSheetState>(
                //     builder: (context, state) {
                //       if (state is NumberOfProductsInCart) {
                //         return TextButton(
                //           onPressed: () {
                //             _management.add(SentToCart());
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => const CartPgae()));
                //           },
                //           child: Text(
                //             (state.numberOfProducts.isEmpty)
                //                 ? 'Cart'
                //                 : '${state.numberOfProducts} Cart',
                //             style: const TextStyle(
                //                 color: Colors.black, fontSize: 20),
                //           ),
                //         );
                //       } else {
                //         return const SizedBox();
                //       }
                //     },
                //   ),
                // )
              ],
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                child: const Row(
                  children: [
                    Text(
                      'DEALBERG',
                      style: TextStyle(color: Colors.grey, fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
      body: Column(
        children: [
          SearchContainer(
            controllerSearch: _controllerSearch,
            height: height * 0.05,
            width: width,
            top: height * 0.02,
          ),
          BlocProvider(
            create: (_) => _management,
            child: BlocBuilder<ProductsManagement, StateBloc>(
                builder: (context, state) {
              if (state is AllProducts) {
                return Expanded(
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
                                _management.add(
                                    AddToCart(prod: state.allProducts[index]));
                                _bottomSheet.add(AddAmountEvent());
                              },
                              pName: state.allProducts[index].productName!,
                              discription:
                                  state.allProducts[index].description!,
                              price: state.allProducts[index].price!,
                              quantity: (state.allProducts[index].quantity! > 0)
                                  ? state.allProducts[index].quantity.toString()
                                  : '',
                              onTapDec: () {
                                _management.add(RmvToCart(
                                    id: state.allProducts[index].id!));
                                _bottomSheet.add(AddAmountEvent());
                              },
                              negativeButton:
                                  (state.allProducts[index].quantity! > 0)
                                      ? true
                                      : false,
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                          ],
                        );
                      }),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ],
      ),
      bottomSheet: BlocProvider(
        create: (_) => _bottomSheet,
        child: BlocBuilder<BottomSheetBloc, BottomSheetState>(
          builder: (context, state) {
            if (state is ShowBottomSheetState) {
              return Container(
                height: height * 0.1,
                decoration: const BoxDecoration(
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
                        style:
                            const TextStyle(color: Colors.black, fontSize: 25),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.42),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartPgae()));
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStatePropertyAll<Color>(
                              Colors.grey.shade100),
                        ),
                        child: const Text(
                          'Cart',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
