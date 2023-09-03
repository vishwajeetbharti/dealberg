part of 'bloc.dart';

abstract class EventBloc {}

class InitialEvent extends EventBloc {
  InitialEvent();
}

class AddToCart extends EventBloc {
  DealProducts prod;
  AddToCart({required this.prod});
}

class RmvToCart extends EventBloc {
  String id;
  RmvToCart({required this.id});
}

class SentToCart extends EventBloc {
  SentToCart();
}
