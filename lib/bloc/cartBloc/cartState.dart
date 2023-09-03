part of 'cartBloc.dart';

abstract class CartState {}

class LoadingState extends CartState {
  String error;
  LoadingState({required this.error});
}

class CartProducts extends CartState {
  List<DealProducts> allProducts;
  CartProducts({required this.allProducts});
}
