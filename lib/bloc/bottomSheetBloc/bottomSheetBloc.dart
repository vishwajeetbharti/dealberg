import 'dart:convert';

import 'package:dealberg/model/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

part 'bottomSheetEvent.dart';
part 'bottomSheetState.dart';

class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(HideBottomSheetState()) {
    on<AddAmountEvent>((event, emit) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      double totalAmt = 0;
      var prod = preferences.getString(Strings.product) ?? '';
      if (prod.isNotEmpty) {
        List<DealProducts> list = (json.decode(prod) as List)
            .map((data) => DealProducts.fromJson(data))
            .toList();
        for (var value in list) {
          totalAmt = totalAmt + double.parse(value.price!) * value.quantity!;
        }
      }
      if (totalAmt > 0) {
        emit(ShowBottomSheetState(totalAmt: totalAmt.toString()));
      } else {
        emit(HideBottomSheetState());
      }
    });
    on<NumberOfProducts>((event, emit) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      int totalProducts = 0;
      List<DealProducts> list =
          (json.decode(preferences.getString(Strings.product) ?? '') as List)
              .map((data) => DealProducts.fromJson(data))
              .toList();
      for (var value in list) {
        totalProducts = totalProducts + value.quantity!;
      }
      emit(NumberOfProductsInCart(numberOfProducts: totalProducts.toString()));
    });
  }
}
