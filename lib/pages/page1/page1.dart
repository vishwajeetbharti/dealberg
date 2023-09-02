import 'package:dealberg/pages/page1/widgets/productCards.dart';
import 'package:dealberg/pages/page1/widgets/search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _controllerSearch = TextEditingController();
  final ProductsManagement _management = ProductsManagement();

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
                TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll<Color>(Colors.grey.shade100),
                    ),
                    child: const Text(
                      'Cart',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ))
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
                              pName: state.allProducts[index].productName!,
                              price: state.allProducts[index].price!,
                              description:
                                  state.allProducts[index].description!,
                            ),
                            SizedBox(
                              width: width * 0.05,
                            ),
                          ],
                        );
                      }),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
          ),
        ],
      ),
    );
  }
}
