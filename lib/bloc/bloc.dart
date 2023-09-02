import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/products_model.dart';

part 'bloc_events.dart';
part 'bloc_states.dart';

class ProductsManagement extends Bloc<EventBloc, StateBloc> {
  ProductsManagement() : super(LoadingState(error: 'loading')) {
    on<InitialEvent>((event, emit) async {
      try {
        var response = await http
            .get(Uri.https("64f30ce8edfa0459f6c63c41.mockapi.io", "/products"));
        List<DealProducts> list = (json.decode(response.body) as List)
            .map((data) => DealProducts.fromJson(data))
            .toList();
        emit(AllProducts(allProducts: list));
      } catch (e) {
        emit(LoadingState(error: 'Api Error'));
      }
    });
    on<AddTOCart>((event, emit) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      // preferences.setStringList(event.prod.id!, [event.prod.productName!,event.prod.description])
    });
  }
}
