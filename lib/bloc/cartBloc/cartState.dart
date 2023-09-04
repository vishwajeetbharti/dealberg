part of 'cartBloc.dart';

abstract class CartState {}

class LoadingCartState extends CartState {
  String error;
  LoadingCartState({required this.error});
}

class CartProducts extends CartState {
  List<DealProducts> allProducts;
  CartProducts({required this.allProducts});
}
