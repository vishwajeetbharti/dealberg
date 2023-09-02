part of 'bloc.dart';

abstract class StateBloc {}

class LoadingState extends StateBloc {
  String error;
  LoadingState({required this.error});
}

class AllProducts extends StateBloc {
  List<DealProducts> allProducts;
  AllProducts({required this.allProducts});
}
