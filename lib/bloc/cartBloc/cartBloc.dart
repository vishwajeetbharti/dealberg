import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/products_model.dart';

part 'cartEvent.dart';
part 'cartState.dart';

class CartManagement extends Bloc<CartEvent, CartState> {
  CartManagement() : super(LoadingState(error: 'loading')) {
    List<DealProducts> selectedProducts = [];
    on<GetProducts>((event, emit) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      double totalAmt = 0;

      List<DealProducts> list =
          (json.decode(preferences.getString('product') ?? '') as List)
              .map((data) => DealProducts.fromJson(data))
              .toList();
      for (var value in list) {
        if (value.quantity! > 0) {
          selectedProducts.add(value);
        }
      }
      emit(CartProducts(allProducts: selectedProducts));
    });
  }
}
