import 'package:dealberg/Utils/constants.dart';
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
  final ProductsManagement _management = ProductsManagement();
  final BottomSheetBloc _bottomSheet = BottomSheetBloc();

  @override
  void initState() {
    super.initState();
    _management.add(InitialEvent());
    _bottomSheet.add(AddAmountEvent());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: !kIsWeb
          ? AppBar(
              title: const Text(
                Strings.title,
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            )
          : const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Row(
                children: [
                  Text(
                    Strings.title,
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                  )
                ],
              ),
            ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchContainer(
                onChange: (text) {
                  _management.add(SearchProduct(key: text));
                },
                height: height * 0.05,
                width: width * 0.9,
                top: height * 0.02,
              ),
            ],
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
                                  AddToCart(
                                    prod: state.allProducts[index],
                                    imgLink: image[index],
                                  ),
                                );
                                _bottomSheet.add(
                                  AddAmountEvent(),
                                );
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
                              imageLink: image[index],
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                          ],
                        );
                      }),
                );
              } else if (state is LoadingState) {
                return Center(
                  child: Text(
                    state.error,
                    style: TextStyle(fontSize: width * 0.05),
                  ),
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
                        style: TextStyle(
                            color: Colors.black, fontSize: width * 0.05),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.42),
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          border: Border.all(color: Colors.black54),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartPgae()))
                              .then((value) {
                            _bottomSheet.add(AddAmountEvent());
                            _management.add(InitialEvent());
                          });
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStatePropertyAll<Color>(
                              Colors.grey.shade100),
                        ),
                        child: Text(
                          Strings.cart,
                          style: TextStyle(
                              color: Colors.black, fontSize: width * 0.05),
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
