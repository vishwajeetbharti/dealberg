import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';
import '../../model/products_model.dart';

part 'bloc_events.dart';
part 'bloc_states.dart';

class ProductsManagement extends Bloc<EventBloc, StateBloc> {
  ProductsManagement() : super(LoadingState(error: 'loading')) {
    List<DealProducts> list = [];
    List<DealProducts> cartList = [];
    on<InitialEvent>((event, emit) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      try {
        var response = await http.get(Uri.https(Strings.api, Strings.path));
        list = (json.decode(response.body) as List)
            .map((data) => DealProducts.fromJson(data))
            .toList();
        var prodData = preferences.getString(Strings.product) ?? '';
        if (prodData.isNotEmpty) {
          cartList = (json.decode(prodData) as List)
              .map((data) => DealProducts.fromJson(data))
              .toList();
          for (var value in cartList) {
            for (var element in list) {
              if (value.id == element.id) {
                element.quantity = value.quantity;
              }
            }
          }
        }
        emit(AllProducts(
          allProducts: list,
        ));
      } catch (e) {
        emit(LoadingState(error: Strings.apiError));
      }
    });
    on<AddToCart>((event, emit) async {
      int totalQuantity = 0;
      for (var element in list) {
        if (element.id == event.prod.id) {
          element.quantity = (element.quantity ?? 0) + 1;
        }
        totalQuantity += element.quantity ?? 0;
      }

      if (list.isNotEmpty) {
        List<Map<String, dynamic>> updatedData = [];
        for (var element in list) {
          updatedData.add(
            {
              Strings.productName: element.productName,
              Strings.price: element.price,
              Strings.description: element.description,
              Strings.id: element.id,
              Strings.quantity: element.quantity,
              Strings.image: event.imgLink
            },
          );
        }
        var prod = json.encode(updatedData);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        preferences.setString(Strings.product, prod);
        counterController.sink.add(totalQuantity);
      }
      emit(AllProducts(allProducts: list));
    });

    on<RmvToCart>((event, emit) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      int totalQuantity = 0;
      for (var element in list) {
        if (element.id == event.id) {
          element.quantity = (element.quantity ?? 0) - 1;
        }
        totalQuantity += element.quantity ?? 0;
      }

      if (list.isNotEmpty) {
        List<Map<String, dynamic>> updatedData = [];
        for (var element in list) {
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
        if (updatedData.isNotEmpty) {
          var prod = json.encode(updatedData);

          preferences.setString(Strings.product, prod);
          counterController.sink.add(totalQuantity);
        } else {
          preferences.remove(Strings.product);
        }
      }
      emit(AllProducts(allProducts: list));
    });
    on<SearchProduct>((event, emit) {
      if (event.key.isEmpty) {
        emit(AllProducts(allProducts: list));
      } else {
        List<DealProducts> searchResult = list
            .where((element) =>
                element.productName!
                    .toLowerCase()
                    .contains(event.key.toLowerCase()) ==
                true)
            .toList();
        if (searchResult.isEmpty) {
          emit(LoadingState(error: Strings.notAvailable));
        } else {
          emit(AllProducts(allProducts: searchResult));
        }
      }
    });
  }
}
