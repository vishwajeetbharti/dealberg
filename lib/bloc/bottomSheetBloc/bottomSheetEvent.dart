part of 'bottomSheetBloc.dart';

abstract class BottomSheetEvent {}

class AddAmountEvent extends BottomSheetEvent {
  AddAmountEvent();
}

class NumberOfProducts extends BottomSheetEvent {
  NumberOfProducts();
}
