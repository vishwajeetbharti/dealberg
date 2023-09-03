import 'dart:convert';

import 'package:dealberg/bloc/cartBloc/cartBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/products_model.dart';

part 'bloc_events.dart';
part 'bloc_states.dart';

class ProductsManagement extends Bloc<EventBloc, StateBloc> {
  ProductsManagement() : super(LoadingState(error: 'loading')) {
    List<DealProducts> list = [];
    final CartManagement _cart = CartManagement();
    on<InitialEvent>((event, emit) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      try {
        var prodData = preferences.getString('product') ?? '';
        if (prodData.isNotEmpty) {
          list = (json.decode(prodData) as List)
              .map((data) => DealProducts.fromJson(data))
              .toList();
        } else {
          var response = await http.get(
              Uri.https("64f30ce8edfa0459f6c63c41.mockapi.io", "/products"));
          list = (json.decode(response.body) as List)
              .map((data) => DealProducts.fromJson(data))
              .toList();
        }
        emit(AllProducts(
          allProducts: list,
        ));
      } catch (e) {
        emit(LoadingState(error: 'Api Error'));
      }
    });
    on<AddToCart>((event, emit) async {
      for (var element in list) {
        if (element.id == event.prod.id) {
          element.quantity = (element.quantity ?? 0) + 1;
        }
      }

      if (list.isNotEmpty) {
        List<Map<String, dynamic>> updatedData = [];
        for (var element in list) {
          updatedData.add(
            {
              "productName": element.productName,
              "price": element.price,
              "description": element.description,
              "id": element.id,
              "quantity": element.quantity
            },
          );
        }
        var prod = json.encode(updatedData);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('product', prod);
      }
      emit(AllProducts(allProducts: list));
    });

    on<RmvToCart>((event, emit) async {
      for (var element in list) {
        if (element.id == event.id) {
          element.quantity = (element.quantity ?? 0) - 1;
        }
      }

      if (list.isNotEmpty) {
        List<Map<String, dynamic>> updatedData = [];
        for (var element in list) {
          updatedData.add(
            {
              "productName": element.productName,
              "price": element.price,
              "description": element.description,
              "id": element.id,
              "quantity": element.quantity
            },
          );
        }
        var prod = json.encode(updatedData);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString('product', prod);
      }
      _cart.add(GetProducts());
      emit(AllProducts(allProducts: list));
    });
  }
}
