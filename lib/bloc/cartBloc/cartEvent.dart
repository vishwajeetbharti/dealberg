part of 'cartBloc.dart';

abstract class CartEvent {}

class GetProducts extends CartEvent {
  GetProducts();
}

class RmvFromCart extends CartEvent {
  String id;
  RmvFromCart({required this.id});
}

class QuantityIncrement extends CartEvent {
  String id;
  QuantityIncrement({required this.id});
}
