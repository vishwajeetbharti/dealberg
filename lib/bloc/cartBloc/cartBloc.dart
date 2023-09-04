import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';
import '../../model/products_model.dart';

part 'cartEvent.dart';
part 'cartState.dart';

class CartManagement extends Bloc<CartEvent, CartState> {
  CartManagement() : super(LoadingCartState(error: 'loading')) {
    List<DealProducts> selectedProducts = [];
    on<GetProducts>((event, emit) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      List<DealProducts> list =
          (json.decode(preferences.getString(Strings.product) ?? '') as List)
              .map((data) => DealProducts.fromJson(data))
              .toList();
      for (var value in list) {
        if (value.quantity! > 0) {
          selectedProducts.add(value);
        }
      }
      emit(CartProducts(allProducts: selectedProducts));
    });
    on<RmvFromCart>((event, emit) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      int totalQQuantity = 0;
      for (var element in selectedProducts) {
        if (element.id == event.id) {
          element.quantity = (element.quantity ?? 0) - 1;
        }
        totalQQuantity += element.quantity ?? 0;
      }

      if (selectedProducts.isNotEmpty) {
        List<Map<String, dynamic>> updatedData = [];
        for (var element in selectedProducts) {
          if (element.quantity! > 0) {
            updatedData.add(
              {
                Strings.productName: element.productName,
                Strings.price: element.price,
                Strings.description: element.description,
                Strings.id: element.id,
                Strings.quantity: element.quantity,
                Strings.image: element.image
              },
            );
          }
        }
        if (updatedData.isNotEmpty) {
          var prod = json.encode(updatedData);
          preferences.setString(Strings.product, prod);
        } else {
          preferences.remove(Strings.product);
        }
      }
      if (totalQQuantity > 0) {
        emit(CartProducts(allProducts: selectedProducts));
      } else {
        emit(LoadingCartState(error: 'error'));
      }
    });
    on<QuantityIncrement>((event, emit) async {
      for (var element in selectedProducts) {
        if (element.id == event.id) {
          element.quantity = (element.quantity ?? 0) + 1;
        }
      }

      if (selectedProducts.isNotEmpty) {
        List<Map<String, dynamic>> updatedData = [];
        for (var element in selectedProducts) {
          updatedData.add(
            {
              Strings.productName: element.productName,
              Strings.price: element.price,
              Strings.description: element.description,
              Strings.id: element.id,
              Strings.quantity: element.quantity,
              Strings.image: element.image
            },
          );
        }
        var prod = json.encode(updatedData);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString(Strings.product, prod);
      }
      emit(CartProducts(allProducts: selectedProducts));
    });
  }
}
