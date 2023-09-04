part of 'bloc.dart';

abstract class EventBloc {}

class InitialEvent extends EventBloc {
  InitialEvent();
}

class AddToCart extends EventBloc {
  DealProducts prod;
  String imgLink;
  AddToCart({required this.prod, required this.imgLink});
}

class RmvToCart extends EventBloc {
  String id;
  RmvToCart({required this.id});
}

class SentToCart extends EventBloc {
  SentToCart();
}

class SearchProduct extends EventBloc {
  String key;
  SearchProduct({required this.key});
}
