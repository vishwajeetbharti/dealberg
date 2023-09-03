part of 'bottomSheetBloc.dart';

abstract class BottomSheetState {}

class ShowBottomSheetState extends BottomSheetState {
  String totalAmt;
  ShowBottomSheetState({required this.totalAmt});
}

class HideBottomSheetState extends BottomSheetState {
  HideBottomSheetState();
}

class NumberOfProductsInCart extends BottomSheetState {
  NumberOfProductsInCart({required this.numberOfProducts});
  String numberOfProducts;
}
